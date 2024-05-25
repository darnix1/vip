#!/bin/bash

# // color
grs="\033[1;93m"
bg="\033[42m"
gr="\e[92;1m"
NC='\033[0m'

clear
echo -e "\e[38;5;239m════════════════════════════════════════════════════"
echo -e "         \033[45m \033[103m \033[107m\033[30m SCRIPT DARNIX OPTIMIZADO \033[103m \033[45m \e[0m"
echo -e ""
echo -e "\033[38;5;239m═════════════════\e[48;5;1m\e[38;5;230m  MENU AUTO  \e[0m\e[38;5;239m════════════════════"
echo -e ""
echo -e "\e[38;5;239m════════════════════════════════════════════════════"
echo -ne "\e[1;93m  [\e[1;32m1\e[1;93m]\033[1;31m • \e[1;97mCAMBIAR DOMINIO" && echo -e "   \e[1;93m  [\e[1;32m5\e[1;93m]\033[1;31m • \e[1;97mCREAR SLOWDNS"
echo -ne "\e[1;93m  [\e[1;32m2\e[1;93m]\033[1;31m • \e[1;97mCREAR BANNER"  && echo -e "      \e[1;93m  [\e[1;32m6\e[1;93m]\033[1;31m • \e[1;97mSERVICIOS ACTIVOS"
echo -ne "\e[1;93m  [\e[1;32m3\e[1;93m]\033[1;31m • \e[1;97mFIX CERTIFICACION"  && echo -e " \e[1;93m  [\e[1;32m7\e[1;93m]\033[1;31m • \e[1;97mSPEED TEST"
echo -ne "\e[1;93m  [\e[1;32m4\e[1;93m]\033[1;31m • \e[1;97mCLEAR CACHE"      && echo -e "       \e[1;93m  [\e[1;32m8\e[1;93m]\033[1;31m • \e[1;97mVER BANDWIDTH"
#echo -ne "\e[1;93m  [\e[1;32m5\e[1;93m]\033[1;31m • \e[1;97mSHADOWSOCKS" && echo -e "   \e[1;93m  [\e[1;32m11\e[1;93m]\033[1;31m • \e[1;97mINSTALL UDP"
#echo -ne "\e[1;93m  [\e[1;32m6\e[1;93m]\033[1;31m • \e[1;97mTELEGRAM BOT"&& echo -e "  \e[1;93m  [\e[1;32m12\e[1;93m]\033[1;31m • \e[1;97mACTUALIZAR SCRIPT"
echo -e ""
echo -e "    \e[97m\033[1;41m ENTER SIN RESPUESTA REGRESA A MENU ANTERIOR \033[0;97m"
echo -e ""
read -p "$(echo -e "Select From Options [ ${gr}1${NC} - ${gr}8${NC} or ${gr}0${NC} ] : ")" menu
echo -e ""
case $menu in
1) clear ;
    addhost
    ;;
2) clear ;
    nano /etc/kyt.txt
    ;;
3) clear ;
    fixcert
    ;;
4) clear ;
    clearcache
    ;;
5) clear ;
    sd
    ;;
6) clear ;
   run
   ;;
7) clear ;
  speedtest
  ;;
8) clear ;
    bw
    ;;
*)
    menu
    ;;
esac
