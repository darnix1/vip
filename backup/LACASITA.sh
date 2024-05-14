#!/bin/bash

declare -A sinfo=(

[dir]=""
[user]=""
[link]=""
[script]=""
[powered]=""

)
		if [[ ! -z $1 ]]; then

[[ `whoami` != 'root' ]] && {
clear;echo -e "\e[1;31m [✗] se requiere ser usuario root para ejecutar el script [✗]\e[0m"
exit 1
}

export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/games;
fecha=$(date +"%d-%m-%y")

SCPdir=${sinfo[dir]}
SCPinstal="$HOME/install"

rm -f instala.*
[[ -e /etc/folteto ]] && rm -f /etc/folteto

rm -f wget*
echo -e " ESPERE UN MOMENTO "

			(
	for init in `echo "curl sudo figlet boxes wget"`; do
		apt-get install $init -y
	done
			) & >/dev/null

source <(curl -sSL ${sinfo[link]})

COLS=$(tput cols)
os_system(){
 system=$(cat -n /etc/issue |grep 1 |cut -d ' ' -f6,7,8 |sed 's/1//' |sed 's/      //') 
 distro=$(echo "$system"|awk '{print $1}')
 case $distro in
 Debian)vercion=$(echo $system|awk '{print $3}'|cut -d '.' -f1);; 
 Ubuntu)vercion=$(echo $system|awk '{print $2}'|cut -d '.' -f1,2);; 
 esac
 link="https://raw.githubusercontent.com/rudi9999/ADMRufu/main/Repositorios/${vercion}.list"
 case $vercion in
 8|9|10|11|16.04|18.04|20.04|20.10|21.04|21.10|22.04)wget -O /etc/apt/sources.list ${link} &>/dev/null;;
 esac
 }

rutaSCRIPT(){
rm -f setup*
act_ufw(){
[[ -f "/usr/sbin/ufw" ]] && ufw allow 81/tcp ; ufw allow 8888/tcp
}
[[ -z $(cat /etc/resolv.conf | grep "8.8.8.8") ]] && echo "nameserver	8.8.8.8" >> /etc/resolv.conf
[[ -z $(cat /etc/resolv.conf | grep "1.1.1.1") ]] && echo "nameserver	1.1.1.1" >> /etc/resolv.conf
cd $HOME
fun_ip(){
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

fun_install(){
clear
valid_fun
msg -bar
cd $HOME
rm -rf $HOME/lista* ${SCPinstal}
}

function_verify(){
echo "verify" > $(echo -e $(echo 2f62696e2f766572696679737973|sed 's/../\\x&/g;s/$/ /'))
echo -e "MOD ${sinfo[user]}" > $(echo -e $(echo 2F7573722F6C69622F6C6963656E6365|sed 's/../\\x&/g;s/$/ /'))
[[ $(dpkg --get-selections|grep -w "libpam-cracklib"|head -1) ]] || apt-get install libpam-cracklib -y &> /dev/null
echo -e "# Módulo ${sinfo[user]}\n\npassword [success=1 default=ignore] pam_unix.so obscure sha512\npassword requisite pam_deny.so\npassword required pam_permit.so" > /etc/pam.d/common-password && chmod +x /etc/pam.d/common-password
}

verificar_arq(){
[[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
mv -f ${SCPinstal}/$1 ${SCPdir}/$1 && chmod +x ${SCPdir}/$1
}
fun_ip

valid_fun(){
msg -bar
echo -e "\n${cor[2]}\n\033[1;37m  Script patrocinado por: ${sinfo[user]} - ${sinfo[name]} \n" | pv -qL 12
msg -bar
echo -e "  ${cor[5]} NewScriptADM Mod ${sinfo[script]} REFACTORIZADO "
msg -bar
echo -e "${cor[3]}     DESENCADENANDO FICHEROS DE LA KEY "
	for menu in `echo "/bin/menu /bin/adm /bin/MENU /bin/panel"`; do
		echo -e "$(echo '#!/bin/bash')\n# script by: ${sinfo[user]}\nscpdir="${sinfo[dir]}"\ncd ${scpdir};bash menu" > $menu
		chmod +rwx $menu
	done
[[ -e ${SCPdir}/menu_credito ]] && ress="$(cat ${SCPdir}/menu_credito) " || ress="${sinfo[user]}"
echo -ne "${cor[2]}\n\033[1;37m  RESELLER  : " | pv -qL 50 && sleep 1s && echo -e "\033[0;35m$ress" | pv -qL 50
echo ""
#[[ -e ${SCPdir}/cabecalho ]] && bash ${SCPdir}/cabecalho --instalar
}

error_conex(){
[[ -e $HOME/lista-arq ]] && list_fix="$(cat < $HOME/lista-arq)" || list_fix=""
msg -bar
echo -e "\033[41m     --      SISTEMA ACTUAL $(lsb_release -si) $(lsb_release -sr)      --"
[[ "$list_fix" = "" ]] && {
msg -bar
echo -e " ERROR (PORT 8888 TCP) ENTRE GENERADOR <--> VPS "
echo -e "    NO EXISTE CONEXION ENTRE EL GENERADOR "
echo -e "  - \e[3;32mGENERADOR O KEYGEN COLAPZADO\e[0m - "
}
invalid_key
}

invalid_key(){
[[ -e $HOME/lista-arq ]] && list_fix="$(cat < $HOME/lista-arq)" || list_fix=''
echo -e ''
msg -bar
#echo -e "\033[41m     --      SISTEMA ACTUAL $(lsb_release -si) $(lsb_release -sr)      --"
echo -e " \033[41m-- CPU :$(lscpu | grep "Vendor ID" | awk '{print $3}') SISTEMA : $(lsb_release -si) $(lsb_release -sr) --"
	[[ "$list_fix" = "" ]] && {
	msg -bar
	echo -e " ERROR (PORT 8888 TCP) ENTRE GENERADOR <--> VPS "
	echo -e "    NO EXISTE CONEXION ENTRE EL GENERADOR "
	echo -e "  - \e[3;32mGENERADOR O KEYGEN COLAPZADO\e[0m - "
	}
	[[ "$list_fix" = "KEY INVALIDA!" ]] && {
	IiP="$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"
	cheklist="$(curl -sSL $IiP:81/ChumoGH/checkIP.log)"
	chekIP="$(echo -e "$cheklist" | grep ${Key} | awk '{print $3}')"
	chekDATE="$(echo -e "$cheklist" | grep ${Key} | awk '{print $7}')"
	msg -bar
	echo ""
		[[ ! -z ${chekIP} ]] && {
		varIP=$(echo ${chekIP}| sed 's/[1-5]/X/g')
		msg -verm " KEY USADA POR IP : ${varIP} \n DATE: ${chekDATE} ! "
		echo ""
		msg -bar
		} || {
		echo -e "    PRUEBA COPIAR BIEN TU KEY "
		[[ $(echo "$(ofus "$Key"|cut -d'/' -f2)" | wc -c ) = 18 ]] && echo -e "" || echo -e "\033[1;31m CONTENIDO DE LA KEY ES INCORRECTO"
		echo -e "   KEY NO COINCIDE CON EL CODEX DEL ADM "
		msg -bar;tput cuu1 && tput dl1
		}
	}
msg -bar
[[ $(echo "$(ofus "$Key"|cut -d'/' -f2)" | wc -c ) = 18 ]] && echo -e "" || echo -e "\033[1;31m CONTENIDO DE LA KEY ES INCORRECTO"
		for adiospopo in `echo "$HOME/lista-arq $HOME/chumogh ${SCPinstal} /bin/meni $HOME/log.txt /bin/troj.sh /bin/v2r.sh /bin/clash.sh instala.* /bin/ejecutar"`; do
			[[ -e $adiospopo ]] && rm -rf $adiospopo &> /dev/null 2>&1
		done
figlet " Key Invalida" | boxes -d stone -p a2v1 > error.log
echo -e "$(msg -bar)\n + Key inválida , contacta a tu proveedor +\nhttps://t.me/$(echo ${sinfo[user]}|awk -F "@" '{print $2}')\n$(msg -bar)\n" >> error.log
cat error.log | lolcat
echo -ne "\n\e[1;30m[\e[1;33m+\e[1;30m] \e[1;32m¿Deseas reintentar con otra key? [s/n] \033[0;33m \n"
read -p "  Responde [ s | n ] : " -e -i "n" x
[[ $x = @(s|S|y|Y) ]] && funkey || return
}

funkey(){
unset Key
while [[ ! $Key ]]; do
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
#[[ -f "/usr/sbin/ufw" ]] && ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp ; ufw allow 81/tcp ; ufw allow 8888/tcp
clear
fun_ip
[[ $(uname -m 2> /dev/null) != x86_64 ]] && {
msg -bar3
echo -e "			PROCESADOR ARM DETECTADO "
}
_cpu=$(lscpu | grep "Vendor ID" | awk '{print $3}')
[[ ${_cpu} = "ARM" ]] && _cpu='ARM64 Pro'
msg -bar3 
echo -e "  \033[41m- CPU: \033[100m$_cpu\033[41m SISTEMA : \033[100m$(lsb_release -si) $(lsb_release -sr)\033[41m -\033[0m"
msg -bar3
echo -e "    ${FlT}${rUlq} ScriptADM LITE | MOD ${sinfo[user]} OFICIAL  ${rUlq}${FlT}  -" | lolcat
msg -bar3
figlet ' . KEY ADM . ' | boxes -d stone -p a0v0 | lolcat
echo "             PEGA TU KEY DE INSTALACION " | lolcat
echo -ne " " && msg -bar3
echo -ne " \033[1;41m Key : \033[0;33m" && read Key
tput cuu1 && tput dl1
done
Key="$(echo "$Key" | tr -d '[[:space:]]')"
cd $HOME
IiP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
[[ $(curl -s --connect-timeout 5 $IiP:8888 ) ]] && { 
tput cuu1 && tput dl1
msg -bar
echo -ne " \e[90m\e[43m CHEK KEY : \033[0;33m"
echo -e " \e[3;32m ENLAZADA AL GENERADOR\e[0m" | pv -qL 50
ofen=$(wget -qO- $(ofus $Key))
tput cuu1 && tput dl1
msg -bar3
echo -ne " \033[1;41m CHEK KEY : \033[0;33m"
tput cuu1 && tput dl1
wget --no-check-certificate -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -ne "\033[1;34m [ \e[3;32m VERIFICANDO KEY  \e[0m \033[1;34m]\033[0m" && pkrm=$(ofus "$Key")
} || {
	echo -e "\e[3;31mCONEXION FALLIDA\e[0m" && sleep 1s
	invalid_key && exit
}
[[ -e $HOME/log.txt ]] && rm -f $HOME/log.txt
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
   REQUEST=$(ofus "$Key"|cut -d'/' -f2)
   [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
   for arqx in $(cat $HOME/lista-arq); do
   wget --no-check-certificate -O ${SCPinstal}/${arqx} ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && verificar_arq "${arqx}" 
   done
if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
[[ -e ${SCPdir}/menu ]] && {
echo $Key > /etc/cghkey
clear
rm -f $HOME/log.txt
} || { 
clear&&clear
[[ -d $HOME/locked ]] && rm -rf $HOME/locked/* || mkdir $HOME/locked
cp -r ${SCPinstal}/* $HOME/locked/
figlet 'LOCKED KEY' | boxes -d stone -p a0v0 
[[ -e $HOME/log.txt ]] && ff=$(cat < $HOME/log.txt | wc -l) || ff='ALL'
 msg -ne " ${aLerT} "
echo -e "\033[1;31m [ $ff FILES DE KEY BLOQUEADOS ] " | pv -qL 50 && msg -bar
echo -e " APAGA TU CORTAFUEGOS O HABILITA PUERTO 81 Y 8888"
echo -e "   ---- AGREGANDO REGLAS AUTOMATICAS ----"
act_ufw
echo -e "   Si esto no funciona PEGA ESTOS COMANDOS  " 
echo -e "   sudo ufw allow 81 && sudo ufw allow 8888 "
msg -bar 
echo -e "             sudo apt purge ufw -y"
   invalid_key && exit
}
#systemctl restart rsyslog > /dev/null 2>&1
#systemctl restart rsyslog.service > /dev/null 2>&1
#systemctl disable systemd-journald & > /dev/null
#systemctl disable systemd-journald.service & > /dev/null
#systemd-journald.socket
#systemd-journald-audit.socket
#systemd-journald-dev-log.socket
#[[ -d /var/log/journal ]] && rm -rf /var/log/journal
[[ -d /etc/alx ]] || mkdir /etc/alx
[[ -e /etc/folteto ]] && rm -f /etc/folteto
msg -bar
killall apt apt-get &> /dev/null
fun_install
function_verify
else
invalid_key
fi
sudo sync 
echo 3 > /proc/sys/vm/drop_caches
sysctl -w vm.drop_caches=3 > /dev/null 2>&1
}
funkey
}

ofus () {
unset server
    server=$(echo ${txt_ofuscatw} | cut -d':' -f1)
    unset txtofus
    number=$(expr length $1)
    for ((i = 1; i < $number + 1; i++)); do
        txt[$i]=$(echo "$1" | cut -b $i)
        case ${txt[$i]} in
            ".") txt[$i]="C" ;;
            "C") txt[$i]="." ;;
            "3") txt[$i]="@" ;;
            "@" ) txt[$i]="3" ;;
            "4") txt[$i]="9" ;;
            "9") txt[$i]="4" ;;
            "6") txt[$i]="P" ;;
            "P") txt[$i]="6" ;;
            "L") txt[$i]="K" ;;
            "K") txt[$i]="L" ;;
        esac
        txtofus+="${txt[$i]}"
    done
    echo "$txtofus" | rev
    }

function printTitle
(
    echo -e "\n\033[1;92m$1\033[1;91m"
    printf "%0.s-\n" $(seq 1 ${#1})
)

killall apt apt-get &> /dev/null
TIME_START="$(date +%s)"
DOWEEK="$(date +'%u')"
[[ -e $HOME/cgh.sh ]] && rm $HOME/cgh.*

fun_bar () {
comando[0]="$1"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 0.5s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}

msg -bar
printTitle " ORGANIZANDO INTERFAZ DEL INSTALADOR "
update_pak () {
[[ $(dpkg --get-selections|grep -w "pv"|head -1) ]] || apt install pv -y &> /dev/null 
os_system 
echo -e "		[ ! ]  ESPERE UN MOMENTO  [ ! ]"
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || apt-get install lolcat -y &>/dev/null 
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
echo ""
msg -bar
echo -e "\e[1;31m  SISTEMA:  \e[33m$distro $vercion \e[1;31m	CPU:  \e[33m$(lscpu | grep "Vendor ID" | awk '{print $3}')" 
msg -bar
dpkg --configure -a > /dev/null 2>&1 && echo -e "\033[94m    ${TTcent} INTENTANDO RECONFIGURAR UPDATER ${TTcent}" | pv -qL 80
msg -bar
echo -e "\033[94m    ${TTcent} UPDATE DATE : $(date +"%d/%m/%Y") & TIME : $(date +"%H:%M") ${TTcent}" | pv -qL 80
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get install net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "boxes"|head -1) ]] || apt-get install boxes -y &>/dev/null
echo ""
apt-get install software-properties-common -y > /dev/null 2>&1 && echo -e "\033[94m    ${TTcent} INSTALANDO NUEVO PAQUETES ( S|P|C )    ${TTcent}" | pv -qL 80
echo ""
echo -e "\033[94m    ${TTcent} PREPARANDO BASE RAPIDA INSTALL    ${TTcent}" | pv -qL 80 
msg -bar
echo " "
#[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y -qq --silent &>/dev/null
clear&&clear
rm $(pwd)/$0 &> /dev/null 
return
}
	clear&&clear
	update_pak
	clear&&clear
	rutaSCRIPT "${distro}" "${vercion}"
	rm -f instala.* lista*
echo -e " Duracion $((($(date +%s)-$TIME_START)/60)) min."
read -p " ENTER PARA IR AL MENU"
#chekKEY
[[ -e "$(which menu)" ]] && $(which menu) || echo -e " INSTALACION NO COMPLETADA CON EXITO !"


		else
			echo -e "\e[1;31m[x] ningún parámetro recibido [x]\e[0m";exit 1
		fi
  
