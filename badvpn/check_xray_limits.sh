#!/bin/bash

# Configuración
CONFIG_FILE="/usr/local/etc/xray/config/04_inbounds.json"
USER_LIMITS_FILE="/etc/xray/user_limits.csv"
LOG_FILE="/var/log/xray_limits.log"
BOT_TOKEN=$(cat /etc/bot_telegram 2>/dev/null)
CHAT_ID=$(cat /etc/user_telegram 2>/dev/null)

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
    
    sed -i "/^#&@ $user $exp/,/^},{/d" "$CONFIG_FILE" 2>/dev/null && {
        sed -i "/^$user,/d" "$USER_LIMITS_FILE"
        rm -f "/var/www/html/xray/xray-$user.html" "/user/xray-$user.log"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Eliminado: $user (Exp: $exp)" >> "$LOG_FILE"
        return 0
    }
    return 1
}

# Función para convertir números científicos a enteros
convert_to_int() {
    printf "%.0f" "$1"
}

# Función principal
check_limits() {
    local traffic_data=$(python3 /usr/local/bin/xraymonitor_json.py 2>/dev/null || echo "[]")
    
    while IFS=, read -r user limit_gb exp; do
        [ -z "$user" ] && continue
        
        # Obtener consumo y convertir a bytes (manejo de notación científica)
        local consumption=$(echo "$traffic_data" | jq -r ".[] | select(.user == \"$user\") | .value")
        local limit_bytes=$(awk "BEGIN {print $limit_gb * 1073741824}")

        # Convertir valores a enteros para comparación
        local consumption_int=$(convert_to_int "${consumption:-0}")
        local limit_int=$(convert_to_int "${limit_bytes:-0}")

        # Verificar expiración
        if [ "$(date +%Y-%m-%d)" == "$exp" ]; then
            delete_user "$user" && notify_telegram "⌛ <b>Usuario Expirado:</b> <code>$user</code>\n📅 <b>Fecha:</b> $exp"

        # Verificar límite de datos (comparación segura)
        elif [ -n "$consumption" ] && [ "$consumption_int" -ge "$limit_int" ]; then
            if delete_user "$user"; then
                local consumo_gb=$(echo "scale=2; $consumption/1073741824" | bc)
                notify_telegram "🚨 <b>Usuario Eliminado:</b> <code>$user</code>\n📊 <b>Consumo:</b> $consumo_gb GB\n⚖️ <b>Límite:</b> $limit_gb GB"
            fi
        fi
    done < "$USER_LIMITS_FILE"

    # Reiniciar Xray si hubo cambios (con verificación)
    if grep -q "Eliminado:" "$LOG_FILE"; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Reiniciando Xray..." >> "$LOG_FILE"
        if ! systemctl reload xray 2>/dev/null; then
            systemctl restart xray
        fi
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Xray reiniciado" >> "$LOG_FILE"
    fi
}

# Ejecutar con manejo de errores
check_limits || {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error al ejecutar check_limits" >> "$LOG_FILE"
    exit 1
}
