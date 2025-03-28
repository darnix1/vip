#!/bin/bash
BOT_TOKEN=$(cat /etc/bot_telegram)
CHAT_ID=$(cat /etc/user_telegram)

notify_telegram() {
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d "chat_id=${CHAT_ID}" \
        -d "text=$1" \
        -d "parse_mode=HTML" > /dev/null
}

check_limit() {
    local user=$1 limit_gb=$2 exp=$3
    local limit_bytes=$(awk "BEGIN {print $limit_gb * 1024 * 1024 * 1024}")
    # Cambio clave: Usar xray_monitor_json.py en lugar de xray_monitor.py
    local traffic_data=$(python3 /usr/local/bin/xray_monitor_json.py)
    local consumption=$(echo "$traffic_data" | jq -r ".[] | select(.user == \"$user\") | .value")

    if [ "$(date +%Y-%m-%d)" == "$exp" ]; then
        sed -i "/\"email\": \"$user\"/d" /usr/local/etc/xray/config.json
        notify_telegram "⌛ <b>Usuario Expirado:</b> $user\n📅 $exp"
        sed -i "/^$user,/d" /etc/xray/user_limits.csv
    elif [ -n "$consumption" ] && [ "$consumption" -ge "$limit_bytes" ]; then
        sed -i "/\"email\": \"$user\"/d" /usr/local/etc/xray/config.json
        notify_telegram "🚨 <b>Usuario Eliminado:</b> $user\n📊 <b>Consumo:</b> $limit_gb GB"
        sed -i "/^$user,/d" /etc/xray/user_limits.csv
    fi
}

while IFS=, read -r user limit_gb exp; do
    check_limit "$user" "$limit_gb" "$exp"
done < /etc/xray/user_limits.csv
