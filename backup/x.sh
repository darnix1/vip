helicex() {
    downloader_files >/dev/null 2>&1 &
    tput civis
    colors=("31" "32" "33" "34" "35")  # Lista de códigos de color ANSI para los puntos
    end_time=$((SECONDS + 5))  # Define el tiempo de finalización a 5 segundos en el futuro

    while [ $SECONDS -lt $end_time ]; do
        for i in {1..10}; do
            color_index=$(( (i-1) % ${#colors[@]} ))  # Calcula el índice del color
            color="\033[${colors[$color_index]}m"  # Obtiene el código de color ANSI
            echo -ne "\r${color}$(printf '.%.0s' $(seq $i))\033[0m     "
            sleep 0.1
            if [ $SECONDS -ge $end_time ]; then
                break  # Sale del bucle for si el tiempo ha alcanzado o excedido 5 segundos
            fi
        done
    done

    tput cnorm
}

helicex
