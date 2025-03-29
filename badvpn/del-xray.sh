#!/bin/bash

# Configuración de colores
COLOR1='\033[0;35m'
WH='\033[0;39m'
COLBG1='\033[30;48;5;82m'
Xark="\033[0m"
XRAY_API="127.0.0.1:10000"

# Función para la API de Xray
xray_api() {
    curl -s -X POST "http://${XRAY_API}/api" -H "Content-Type: application/json" -d "$1"
}

# Diseño de línea
baris_panjang() {
    echo -e "\033[5;36m ◇━━━━━━━━━━━━━━━━━◇\033[0m"
}

# Créditos
Sc_Credit() {
    sleep 1
    baris_panjang
    echo -e "\e[92;1m      Terimakasih Telah Menggunakan \033[0m"
    echo -e "\e[92;1m            Script 𝗙𝗔𝗡𝗡𝗧𝗨𝗡𝗘𝗟 \033[0m"
    baris_panjang
    exit 1
}

# Verificar si hay usuarios
NUMBER_OF_CLIENTS=$(grep -c -E "^#&@ " "/usr/local/etc/xray/config/04_inbounds.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    clear
    echo -e "${COLOR1}————————————————————————"
    echo -e "${WH}    Delete All Xray Account"
    echo -e "${COLOR1}————————————————————————"
    echo -e "${WH}    You have no existing clients!"
    echo -e "${COLOR1}————————————————————————"
    read -n 1 -s -r -p "Press any key to back on menu"
    Sc_Credit
fi

# Mostrar lista de usuarios
clear
echo -e "${COLOR1}————————————————————————"
echo -e "${WH}    Delete All Xray Account"
echo -e "${COLOR1}————————————————————————"
echo -e "${WH}      User  Expired"
echo -e "${COLOR1}————————————————————————"
grep -E "^#&@ " "/usr/local/etc/xray/config/04_inbounds.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
echo -e "${WH}tap enter to go back"
echo -e "${COLOR1}————————————————————————"
read -rp "Input Username : " user

if [ -z "$user" ]; then
    Sc_Credit
else
    # Obtener email y expiración
    exp=$(grep -wE "^#&@ $user" "/usr/local/etc/xray/config/04_inbounds.json" | cut -d ' ' -f 3 | sort | uniq)
    email=$(grep -wE "^#&@ $user" -A10 "/usr/local/etc/xray/config/04_inbounds.json" | grep -m1 '"email"' | cut -d '"' -f4)

    # Eliminar via API (si existe email)
    if [ -n "$email" ]; then
        xray_api '{"method":"removeUser","params":["'"$email"'"]}' >/dev/null 2>&1
    fi

    # Eliminar de la configuración
    sed -i "/^#&@ $user $exp/,/^},{/d" "/usr/local/etc/xray/config/04_inbounds.json" 2>/dev/null

    # Limpiar archivos asociados
    rm -f "/var/www/html/xray/xray-$user.html" "/user/xray-$user.log"

    # Recargar Xray sin reinicio completo (si es posible)
    if ! systemctl reload xray 2>/dev/null; then
        systemctl restart xray
    fi

    # Mostrar resultado
    clear
    echo -e "${COLOR1}————————————————————————"
    echo -e "${COLBG1}All Xray Account Success Deleted"
    echo -e "${COLOR1}————————————————————————"
    echo -e "${COLBG1} Client Name : ${WH}$user"
    echo -e "${COLBG1} Email       : ${WH}${email:-Not Found}"
    echo -e "${COLBG1} Expired On  : ${WH}$exp"
    echo -e "${COLOR1}————————————————————————"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    clear
    Sc_Credit
fi
