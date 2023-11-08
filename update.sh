#wget https://github.com/${GitUser}/

echo ""
version=$(cat /home/ver)
ver=$( curl https://raw.githubusercontent.com/darnix1/vip/main/version.conf )
clear
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# CEK UPDATE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info1="${Green_font_prefix}($version)${Font_color_suffix}"
Info2="${Green_font_prefix}(ULTIMA VERSION)${Font_color_suffix}"
Error="Version ${Green_font_prefix}[$ver]${Font_color_suffix} Actualizacion Disponible
${Red_font_prefix}[Actualiza el Script]${Font_color_suffix}"
version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/darnix1/vip/main/version.conf | grep $version )
#Status Version
if [ $version = $new_version ]; then
stl="${Info2}"
else
stl="${Error}"
fi
clear
echo ""
echo -e "   \e[$line--------------------------------------------------------\e[m"
echo -e "   \e[$back_text                 \e[30m[\e[$box CHECK NEW UPDATE\e[30m ]                   \e[m"
echo -e "   \e[$line--------------------------------------------------------\e[m"
echo -e "   \e[$below   VERSION ACTUAL >> $Info1"
echo -e "   \e[$below   ESTDADO ACTUAL >> $sts"
echo -e ""
echo -e "       \e[1;31m¿Quieres continuar?\e[0m"
echo ""
echo -e "            \e[0;32m[  Seleciona una Opcion ]\033[0m"
echo -e "     \e[$number [1]\e[m \e[$below  >\e[m"
echo -e "     \e[$number [1]\e[m \e[$below  Actualizar\e[m"
echo -e "     \e[$number [x]\e[m \e[$below  Menu\e[m"
echo -e ""
echo -e "   \e[$line--------------------------------------------------------\e[m"
echo -e "\e[$line"
read -p "Escoge 1, x , y : " option2
case $option2 in
1)
version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/darnix1/vip/main/version.conf | grep $version )
if [ $version = $new_version ]; then
clear
echo ""
echo -e "\e[1;31mComprobando la nueva versión, espere...!\e[m"
sleep 3
clear
echo -e "\e[1;31mActualización no disponible\e[m"
echo ""
clear
sleep 1
echo -e "\e[1;36mTienes la última versión\e[m"
echo -e "\e[1;31mThankyou.\e[0m"
sleep 3
menu
fi
clear
echo -e "\e[1;31mActualización disponible ahora..\e[m"
echo -e ""
sleep 2
echo -e "\e[1;36mInicie la actualización para la nueva versión, espere..\e[m"
sleep 2
clear
echo -e "\e[0;32mObtener una nueva versión del script..\e[0m"
sleep 1
echo ""
# UPDATE RUN-UPDATE

echo ""
clear
echo -e "\e[0;32mEspere por favor...!\e[0m"
sleep 6
clear
echo ""
echo -e "\e[0;32mSe inició la descarga de la nueva versión!\e[0m"
sleep 2

wget https://raw.githubusercontent.com/darnix1/vip/main/menu/menu.zip
    unzip -P "alex2023" menu.zip
    chmod +x menu/*
    mv menu/* /usr/local/sbin
    rm -rf menu
    rm -rf menu.zip
    
    
clear
echo -e ""
echo -e "\e[0;32mDescargado exitosamente!\e[0m"
echo ""
ver=$( curl https://raw.githubusercontent.com/darnix1/vip/main/version.conf )
sleep 1
echo -e "\e[0;32mParchando nueva actualización, espere...\e[0m"
echo ""
sleep 2
echo -e "\e[0;32mParchado... OK!\e[0m"
sleep 1
echo ""
echo -e "\e[0;32mScript de actualización exitosa para la nueva versión\e[0m"
cd
echo "$ver" > /home/ver
rm -f update.sh
clear
echo ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m            SCRIPT UPDATED              \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
x)
clear
update
;;
y)
clear
menu
;;
*)
clear
echo -e "\e[1;31mPlease Enter Option 1-2 or x & y Only..,Try again, Thank You..\e[0m"
sleep 2
run-update
;;
esac
