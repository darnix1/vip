helicex() {
    downloader_files >/dev/null 2>&1 &
    tput civis
    colors=("31" "32" "33" "34" "35")  # Lista de códigos de color ANSI para los puntos
    end_time=$((SECONDS + 5))  # Define el tiempo de finalización a 5 segundos en el futuro
    final_line=""

    while [ $SECONDS -lt $end_time ]; do
        for i in {1..10}; do
            color_index=$(( (i-1) % ${#colors[@]} ))  # Calcula el índice del color
            color="\033[${colors[$color_index]}m"  # Obtiene el código de color ANSI
            line="${color}$(printf '●%.0s' $(seq $i))\033[0m     "
            echo -ne "\r${line}"
            sleep 0.1
            if [ $SECONDS -ge $end_time ]; then
                final_line=$line
                break  # Sale del bucle for si el tiempo ha alcanzado o excedido 5 segundos
            fi
        done
    done

    # Imprimir la línea final y restaurar el cursor
    echo -e "\r${final_line}"
    tput cnorm
}

# Para llamar a la función
helicex
