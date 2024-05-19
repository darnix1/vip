#!/bin/bash

until :; do
   while [[ $(echo $1|grep "chukk") = "" ]]; do
      for chukk in `echo 'chukk patomod update start'`; do
        test "$1" == "--$chukk"
        [[ $? != '0' ]] && exit 1
      done
   done
done

apt-get install toilet lolcat figlet pv jq sudo curl -y &> /dev/null
source <(curl -sSL https://raw.githubusercontent.com/CuervoCool/chukkmod/main/Complementos/msg)

function msg(){
declare -A kol=( [0]="ngr" [1]="r" [2]="verd" [3]="ama" [4]="azu" [5]="p" [6]="c" [7]="bra" )
declare -A color=( [sc]='\e[0m' )
	for(( col=0;col<7;col++ )); do
	     color[$col]+="\e[1;3${col}m"
	     color[${kol[$col]}]+="${color[$col]}"
	done
		case $1 in
		  "-bar")echo -e "${color[0]}======================================${color[sc]}";;
	           "-ne")echo -ne "${color[0]}[\e[38;5;52m•\e[1;30m] \e[93m$2${color[2]} "&&read $3;;
		    "-e")echo -e "${color[e]}$2${color[sc]}";;
		       *)x=`echo $1|tr -d "-"`
			echo -e "${color[$x]}$2";;
		esac

}

fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
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
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}

ofus() {
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
        "@") txt[$i]="3" ;;
        "5") txt[$i]="9" ;;
        "9") txt[$i]="5" ;;
	"6") txt[$i]="P" ;;
        "P") txt[$i]="6" ;;
        "L") txt[$i]="O" ;;
        "O") txt[$i]="L" ;;
        esac
        txtofus+="${txt[$i]}"
    done
    echo "$txtofus" | rev
}

rm -rf /etc/chukk-script &> /dev/null

dependencias() {
  dpkg --configure -a >/dev/null 2>&1
  apt -f install -y >/dev/null 2>&1
  soft="sudo grep less zip unzip ufw curl dos2unix python python3 python3-pip openssl cron iptables lsof pv boxes at mlocate gawk bc jq curl socat netcat net-tools cowsay figlet lolcat apache2"
  for i in $soft; do
    paquete="$i"
    echo -e "\033[93m    ❯ \e[97mINSTALANDO PAQUETE \e[36m $i"
#  [[ $(dpkg --get-selections|grep -w "$i"|head -1) ]] || 
   fun_bar "apt-get install $i -y"
  msg -bar
  done
}

clear
printf "%8s $(msg -azu 'INSTALANDO PAQUETES')\n"
msg -bar
dependencias
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf >/dev/null 2>&1
service apache2 restart >/dev/null 2>&1
wget https://gitea.com/drowkid01/scriptdk1/raw/branch/main/Control/chukk.tar &> /dev/null
mkdir -p /etc/chukk-script
tar xpf chukk.tar --directory /etc/chukk-script
rm chukk.tar
msg -ne "ingrese un resseller: " ress
msg -bar
msg -ne "ingrese el nombre del servidor: " name
msg -bar

cat << eof > /etc/chukk-script/menu_credito
$(echo "$ress")
eof

echo $name > /etc/chukk-script/name
ln -s /etc/chukk-script/name /root/name
mkdir /bin/ejecutar &> /dev/null
wget -q -O /bin/ejecutar/msg https://raw.githubusercontent.com/CuervoCool/chukkmod/main/msg-bar/msg &> /dev/null
echo "Verified【 $ress ©" > /bin/ejecutar/exito
cat /etc/chukk-script/v-local.log > /bin/ejecutar/v-new.log
rm /etc/chukk-script/*.txt /etc/chukk-script/0 &> /dev/null

for menu in `echo "/bin/menu /bin/chukk /bin/adm /bin/drowkid"`; do
echo '. /etc/chukk-script/menu' > $menu
chmod +rwx $menu
done
