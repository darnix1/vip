#!/bin/bash

# Configuración
CONFIG_FILE="/usr/local/etc/xray/config/04_inbounds.json"
USER_LIMITS_FILE="/etc/xray/user_limits.csv"
LOG_FILE="/var/log/xray_limits.log"
BOT_TOKEN=$(cat /etc/bot_telegram 2>/dev/null)
CHAT_ID=$(cat /etc/user_telegram 2>/dev/null)

# Crear directorios necesarios
mkdir -p /var/lib/xray
touch "$LOG_FILE"
chmod 644 "$LOG_FILE"

# Función para notificar por Telegram
notify_telegram() {
    [ -z "$BOT_TOKEN" ] || [ -z "$CHAT_ID" ] && return
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d "chat_id=${CHAT_ID}" \
        -d "text=$message" \
        -d "parse_mode=HTML" > /dev/null
}

# Función para eliminar usuario
delete_user() {
    local user="$1"
    local exp=$(grep -wE "^#&@ $user" "$CONFIG_FILE" | cut -d ' ' -f 3)
    
    # Eliminar configuración
    sed -i "/^#&@ $user $exp/,/^},{/d" "$CONFIG_FILE" 2>/dev/null && {
        # Eliminar de registros
        sed -i "/^$user,/d" "$USER_LIMITS_FILE"
        rm -f "/var/www/html/xray/xray-$user.html"
        rm -f "/user/xray-$user.log"
        
        # Registrar en log
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Eliminado: $user (Exp: $exp)" >> "$LOG_FILE"
        return 0
    }
    return 1
}

# Función principal
check_limits() {
    # Obtener datos de consumo
    local traffic_data
    traffic_data=$(python3 /usr/local/bin/xraymonitor_json.py 2>/dev/null) || {
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: No se pudieron obtener estadísticas" >> "$LOG_FILE"
        return 1
    }

    # Procesar cada usuario
    while IFS=, read -r user limit_gb exp; do
        [ -z "$user" ] && continue

        # Obtener consumo acumulado
        local consumption=$(echo "$traffic_data" | jq -r ".[] | select(.user == \"$user\") | .value")
        local limit_bytes=$(awk "BEGIN {print $limit_gb * 1073741824}")

        # Verificar expiración
        if [ "$(date +%Y-%m-%d)" == "$exp" ]; then
            if delete_user "$user"; then
                notify_telegram "⌛ <b>Usuario Expirado:</b> <code>$user</code>\n📅 <b>Fecha:</b> $exp"
            fi

        # Verificar límite de datos
        elif [ -n "$consumption" ] && [ "$consumption" -ge "$limit_bytes" ]; then
            if delete_user "$user"; then
                local consumo_gb=$(echo "scale=2; $consumption/1073741824" | bc)
                notify_telegram "🚨 <b>Usuario Eliminado:</b> <code>$user</code>\n📊 <b>Consumo:</b> $consumo_gb GB\n⚖️ <b>Límite:</b> $limit_gb GB"
            fi
        fi
    done < "$USER_LIMITS_FILE"

    # Reiniciar Xray si hubo cambios
    if grep -q "Eliminado:" "$LOG_FILE"; then
        systemctl restart xray
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Xray reiniciado" >> "$LOG_FILE"
    fi
}

# Ejecutar
check_limits
