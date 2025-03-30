#!/bin/bash

# Configuración
CONFIG_FILE="/usr/local/etc/xray/config/04_inbounds.json"
USER_LIMITS_FILE="/etc/xray/user_limits.csv"
LOG_FILE="/var/log/xray_limits.log"

# Telegram
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

# Función para deshabilitar usuario
disable_user() {
    local user="$1"
    local exp=$(grep -wE "^#&@ $user" "$CONFIG_FILE" | cut -d ' ' -f 3 | sort | uniq)
    
    # Cambiar el UUID del usuario a "00000000-0000-0000-0000-000000000000"
    sed -i "/^#&@ $user $exp/,/^},{/ s/\"id\": \"[^\"]*\"/\"id\": \"00000000-0000-0000-0000-000000000000\"/" "$CONFIG_FILE" 2>/dev/null
    
    # Registrar en log
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Usuario $user deshabilitado (Expiración: $exp)" >> "$LOG_FILE"
    
    return 0
}

# Función principal
check_limits() {
    # Crear log si no existe
    [ ! -f "$LOG_FILE" ] && touch "$LOG_FILE" && chmod 644 "$LOG_FILE"
    
    while IFS=, read -r user limit_gb exp; do
        [ -z "$user" ] && continue  # Saltar líneas vacías
        
        # Obtener consumo actual (en bytes)
        local consumption=$(python3 /usr/local/bin/xraymonitor_json.py 2>/dev/null | \
                          jq -r ".[] | select(.user == \"$user\") | .value")
        
        # Calcular límite en bytes
        local limit_bytes=$(awk "BEGIN {print $limit_gb * 1073741824}")
        
        # Verificar expiración
        if [ "$(date +%Y-%m-%d)" == "$exp" ]; then
            if disable_user "$user"; then
                notify_telegram "⌛ <b>Usuario Expirado:</b> <code>$user</code>\n📅 <b>Fecha:</b> $exp"
            fi
        
        # Verificar límite de datos
        elif [ -n "$consumption" ] && [ "$consumption" -ge "$limit_bytes" ]; then
            if disable_user "$user"; then
                local consumo_gb=$(echo "scale=2; $consumption/1073741824" | bc)
                notify_telegram "🚨 <b>Usuario Deshabilitado:</b> <code>$user</code>\n📊 <b>Consumo:</b> $consumo_gb GB\n⚖️ <b>Límite:</b> $limit_gb GB"
            fi
        fi
    done < "$USER_LIMITS_FILE"
}

# Ejecutar
check_limits
