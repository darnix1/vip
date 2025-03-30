#!/bin/bash

# Configuración
XRAY="/usr/local/bin/xray"
APISERVER="127.0.0.1:10000"
STATS_DB="/var/lib/xray/stats_accumulated.json"

# Colores para la tabla
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
RED='\033[1;31m'
NC='\033[0m' # No Color

# Función para convertir bytes a GB
bytes_to_gb() {
    printf "%.2f" $(echo "$1 / 1073741824" | bc -l)
}

# Obtener estadísticas actuales de Xray
get_current_stats() {
    local stats
    if stats=$("$XRAY" api statsquery --server "$APISERVER" 2>/dev/null); then
        echo "$stats"
    else
        echo '{"stat":[]}' >&2
        return 1
    fi
}

# Actualizar base de datos acumulada
update_accumulated_stats() {
    local current_stats=$1
    declare -A accumulated
    
    # Cargar datos existentes
    [[ -f "$STATS_DB" ]] && source <(jq -r 'to_entries[] | "accumulated[\"\(.key)\"]=\(.value)"' "$STATS_DB" 2>/dev/null)
    
    # Procesar nuevas estadísticas
    while read -r name value; do
        if [[ "$name" =~ user>>>([^>]+)>>>.*>>>(downlink|uplink) ]]; then
            user="${BASH_REMATCH[1]}"
            type="${BASH_REMATCH[2]}"
            key="${user}_${type}"
            accumulated["$key"]=$(( ${accumulated["$key"]:-0} + value ))
        fi
    done < <(echo "$current_stats" | jq -r '.stat[] | "\(.name) \(.value)"')
    
    # Guardar datos actualizados
    mkdir -p "$(dirname "$STATS_DB")"
    declare -p accumulated | jq -R 'fromjson?' | jq -n 'input' > "$STATS_DB"
    
    # Generar reporte
    declare -A report
    for key in "${!accumulated[@]}"; do
        user="${key%_*}"
        type="${key#*_}"
        report["${user}_${type}_gb"]=$(bytes_to_gb "${accumulated[$key]}")
    done
    
    declare -p report | jq -R 'fromjson?' | jq -n 'input'
}

# Mostrar tabla de resultados
show_traffic_table() {
    local report=$1
    
    echo -e "\n${BLUE}┌─────────────────────────────────────────────────────┐"
    echo -e "│ ${YELLOW}CONSUMO ACUMULADO DE TRÁFICO (GB) ${BLUE}                │"
    echo -e "├─────────────────────┬────────────┬──────────┬────────────┤"
    echo -e "│ ${GREEN}Usuario${BLUE}            │ ${GREEN}Descarga ↓${BLUE} │ ${GREEN}Subida ↑${BLUE} │ ${GREEN}Total${BLUE}     │"
    
    # Variables para totales
    local total_down=0
    local total_up=0
    
    # Procesar cada usuario
    while read -r user; do
        down_gb=$(echo "$report" | jq -r ".[\"${user}_downlink_gb\"] // 0")
        up_gb=$(echo "$report" | jq -r ".[\"${user}_uplink_gb\"] // 0")
        total_gb=$(echo "$down_gb + $up_gb" | bc)
        
        printf "${BLUE}│ %-19s │ %-10s │ %-8s │ %-10s │\n" \
               "${user:0:19}" "${down_gb} GB" "${up_gb} GB" "${total_gb} GB"
        
        total_down=$(echo "$total_down + $down_gb" | bc)
        total_up=$(echo "$total_up + $up_gb" | bc)
    done < <(echo "$report" | jq -r 'keys[]' | grep '_downlink_gb$' | sed 's/_downlink_gb//')
    
    local total_all=$(echo "$total_down + $total_up" | bc)
    
    # Mostrar totales
    echo -e "├─────────────────────┼────────────┼──────────┼────────────┤"
    printf "${BLUE}│ ${RED}%-19s${BLUE} │ ${RED}%-10s${BLUE} │ ${RED}%-8s${BLUE} │ ${RED}%-10s${BLUE} │\n" \
           "TOTAL ACUMULADO" "$total_down GB" "$total_up GB" "$total_all GB"
    echo -e "└─────────────────────┴────────────┴──────────┴────────────┘${NC}\n"
}

# Función principal
main() {
    local current_stats=$(get_current_stats)
    local report=$(update_accumulated_stats "$current_stats")
    
    if [[ "$1" == "--json" ]]; then
        # Modo JSON para otros scripts
        echo "$report"
    else
        # Modo visualización interactiva
        show_traffic_table "$report"
    fi
}

main "$@"ñ
