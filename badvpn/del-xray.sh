#!/bin/bash

# Colores
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# Obtener datos
DATA=$(python3 /usr/local/bin/xraymonitor_json.py)

# Mostrar tabla
echo -e "\n${BLUE}┌─────────────────────────────────────────────────────┐"
echo -e "│ ${YELLOW}CONSUMO ACUMULADO DE TRÁFICO (GB) ${BLUE}                │"
echo -e "├─────────────────────┬────────────┬──────────┬────────────┤"
echo -e "│ ${GREEN}Usuario${BLUE}            │ ${GREEN}Descarga ↓${BLUE} │ ${GREEN}Subida ↑${BLUE} │ ${GREEN}Total${BLUE}     │"

# Procesar cada usuario
echo "$DATA" | jq -r '.users[] | "│ \(.user[:18]|"\(.)\(if length>18 then "..." else "" end)") │ \(.downlink_gb) GB │ \(.uplink_gb) GB │ \(.total_gb) GB │"' | while read -r line; do
    echo -e "${BLUE}$line"
done

# Mostrar totales
total_down=$(echo "$DATA" | jq -r '.total_downlink_gb')
total_up=$(echo "$DATA" | jq -r '.total_uplink_gb')
total_all=$(echo "$DATA" | jq -r '.total_all_gb')

echo -e "├─────────────────────┼────────────┼──────────┼────────────┤"
echo -e "│ ${RED}TOTAL ACUMULADO${BLUE}     │ ${RED}$total_down GB${BLUE} │ ${RED}$total_up GB${BLUE} │ ${RED}$total_all GB${BLUE} │"
echo -e "└─────────────────────┴────────────┴──────────┴────────────┘${NC}\n"
