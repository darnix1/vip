#!/bin/bash

# Configuración
COLOR1='\033[0;35m'
WH='\033[0;39m'
COLBG1='\033[30;48;5;82m'
XRAY_API="127.0.0.1:10000"

# Función para llamar a la API de Xray
xray_api() {
    curl -s -X POST "http://${XRAY_API}/api" -H "Content-Type: application/json" -d "$1"
}

# Función para mostrar créditos
Sc_Credit() {
    echo -e "\n${COLOR1}◇━━━━━━━━━━━━━━━━━◇"
    echo -e "\e[92;1m  Gracias por usar \e[0m"
    echo -e "\e[92;1m   FANNTUNEL SCRIPT \e[0m"
    echo -e "${COLOR1}◇━━━━━━━━━━━━━━━━━◇\n"
    exit 0
}

# Verificar si hay usuarios
if [ $(grep -c -E "^#&@ " "/usr/local/etc/xray/config/04_inbounds.json") -eq 0 ]; then
    clear
    echo -e "${COLOR1}————————————————————————"
    echo -e "${WH}    NO HAY USUARIOS PARA ELIMINAR"
    echo -e "${COLOR1}————————————————————————"
    read -n 1 -s -r -p "Presiona cualquier tecla para continuar"
    menu
fi

# Mostrar lista de usuarios
clear
echo -e "${COLOR1}————————————————————————"
echo -e "${WH}    ELIMINAR USUARIO XRAY"
echo -e "${COLOR1}————————————————————————"
grep -E "^#&@ " "/usr/local/etc/xray/config/04_inbounds.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo -e "${COLOR1}————————————————————————"
read -rp "Ingresa el nombre de usuario: " user

if [ -z "$user" ]; then
    menu
else
    # Obtener datos del usuario
    exp=$(grep -wE "^#&@ $user" "/usr/local/etc/xray/config/04_inbounds.json" | cut -d ' ' -f 3)
    email=$(grep -wE "^#&@ $user" -A10 "/usr/local/etc/xray/config/04_inbounds.json" | grep -m1 '"email"' | cut -d '"' -f4)

    # Eliminar mediante API (si existe email)
    if [ -n "$email" ]; then
        if xray_api '{"method":"removeUser","params":["'"$email"'"]}' | grep -q '"success":true'; then
            echo -e "${WH}✔ Usuario eliminado via API"
        else
            echo -e "${WH}✖ No se pudo eliminar via API (usando método alternativo)"
        fi
    fi

    # Eliminar de la configuración
    sed -i "/^#&@ $user $exp/,/^},{/d" "/usr/local/etc/xray/config/04_inbounds.json" 2>/dev/null

    # Eliminar archivos asociados
    rm -f "/var/www/html/xray/xray-$user.html" "/user/xray-$user.log"

    # Mostrar resultado
    clear
    echo -e "${COLOR1}————————————————————————"
    echo -e "${COLBG1} USUARIO ELIMINADO CON ÉXITO"
    echo -e "${COLOR1}————————————————————————"
    echo -e "${WH}Usuario: $user"
    echo -e "${WH}Email: ${email:-No encontrado}"
    echo -e "${WH}Expiración: $exp"
    echo -e "${COLOR1}————————————————————————"
    read -n 1 -s -r -p "Presiona cualquier tecla para continuar"
    menu
fi
