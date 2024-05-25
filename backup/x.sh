#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit darnix
# (C) Copyright 2022
# =========================================

#!/bin/bash
###########- COLOR CODE -##############
colornow=$(cat /etc/julak/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/julak/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/julak/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
###########- END COLOR CODE -##########


# Getting
export CHATID="1210833546"
export KEY="6006599143:AAEgstCAioq35JgX97HaW_G3TAkLKzLZS_w"
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear
# Valid Script



echo -e "\e[38;5;239m════════════════════════════════════════════════════"
echo -e "         \033[45m \033[103m \033[107m\033[30m SCRIPT DARNIX OPTIMIZADO \033[103m \033[45m \e[0m"
echo -e ""
echo -e "\033[38;5;239m══════════════════\e[48;5;1m\e[38;5;230m  MENU SSH  \e[0m\e[38;5;239m════════════════════"
echo -e ""
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}             ${WH}• BANNER PANEL MENU •              ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "${RED}==[ LEA PRIMERO ]==${NC}

1. El formato debe ser HTML. Si no lo entiende, busque en Google.
2. Edite el texto como desee
3. Si lo ha editado, guárdelo, presione CTRL+x+y+enter
4. Para cancelar/salir presione CTRL + x + n‌‌

No olvide reiniciar el vps después de editar el banner‌‌
"
#!/bin/bash

echo -n "Deseas seguir ? (y/n)? "
read answer

if [ -z "$answer" ]; then
  menu
fi

if [ "$answer" == "${answer#[Yy]}" ] ;then
  menu
else
  clear
  # Eliminar el archivo existente
  rm -f /etc/kyt.txt
  
  # Pedir al usuario que introduzca el HTML
  echo "Por favor, introduzca su HTML tipo banner (presione CTRL+D para finalizar):"
  # Leer el HTML del usuario y guardar en el archivo
  cat > /etc/kyt.txt
  
  # Llamar al menú después de guardar el archivo
  menu
fi
