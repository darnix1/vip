#!/bin/bash

echo "$$" >/etc/SCRIPT-LATAM/temp/menuid
clear && clear
echo -e "\a\a\a"
check-update
if [ $(whoami) != 'root' ]; then #-- VERIFICAR ROOT
  echo -e "\033[1;31m -- NECESITAS SER USER ROOT PARA EJECUTAR EL SCRIPT --\n\n\033[97m                DIGITE: \033[1;32m sudo su; menu\n"
  sleep 5s
  exit && exit
fi
rebootnb "totallssh" & ##-->> CONTADOR DE SSH
##-->> COLORES
red=$(tput setaf 1)
gren=$(tput setaf 2)
yellow=$(tput setaf 3)
SCPdir="/etc/SCRIPT-LATAM" && [[ ! -d ${SCPdir} ]] && exit 1
SCTemp="/etc/SCRIPT-LATAM/temp" && [[ ! -d ${SCTemp} ]] && exit 1
SCPfrm="${SCPdir}/botmanager"
if [[ -e /etc/bash.bashrc-bakup ]]; then # -- CHECK AUTORUN
  AutoRun="\033[1;93m[\033[1;32m ON \033[1;93m]"
elif [[ -e /etc/bash.bashrc ]]; then
  AutoRun="\033[1;93m[\033[1;31m OFF \033[1;93m]"
fi
msg() { ##-->> COLORES, TITULO, BARRAS
  ##-->> ACTULIZADOR Y VERCION
  [[ ! -e /etc/SCRIPT-LATAM/temp/version_instalacion ]] && printf '1\n' >/etc/SCRIPT-LATAM/temp/version_instalacion
  v11=$(cat /etc/SCRIPT-LATAM/temp/version_actual)
  v22=$(cat /etc/SCRIPT-LATAM/temp/version_instalacion)
  if [[ $v11 = $v22 ]]; then
    vesaoSCT="\e[1;31m[\033[1;37m Ver.\033[1;32m $v22 \033[1;31m]"
  else
    vesaoSCT="\e[1;31m[\e[31m ACTUALIZAR \e[25m\033[1;31m]"
  fi
  ##-->> COLORES
  local colors="/etc/SCRIPT-LATAM/colors"
  if [[ ! -e $colors ]]; then
    COLOR[0]='\033[1;37m' #GRIS='\033[1;37m'
    COLOR[1]='\e[31m'     #ROJO='\e[31m'
    COLOR[2]='\e[32m'     #VERDE='\e[32m'
    COLOR[3]='\e[33m'     #AMARILLO='\e[33m'
    COLOR[4]='\e[34m'     #AZUL='\e[34m'
    COLOR[5]='\e[91m'     #ROJO-NEON='\e[91m'
    COLOR[6]='\033[1;97m' #BALNCO='\033[1;97m'

  else
    local COL=0
    for number in $(cat $colors); do
      case $number in
      1) COLOR[$COL]='\033[1;37m' ;;
      2) COLOR[$COL]='\e[31m' ;;
      3) COLOR[$COL]='\e[32m' ;;
      4) COLOR[$COL]='\e[33m' ;;
      5) COLOR[$COL]='\e[34m' ;;
      6) COLOR[$COL]='\e[35m' ;;
      7) COLOR[$COL]='\033[1;36m' ;;
      esac
      let COL++
    done
  fi
  NEGRITO='\e[1m'
  SINCOLOR='\e[0m'
  case $1 in
  -ne) cor="${COLOR[1]}${NEGRITO}" && echo -ne "${cor}${2}${SINCOLOR}" ;;
  -ama) cor="${COLOR[3]}${NEGRITO}" && echo -e "${cor}${2}${SINCOLOR}" ;;
  -verm) cor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${cor}${2}${SINCOLOR}" ;;
  -verm2) cor="${COLOR[1]}${NEGRITO}" && echo -e "${cor}${2}${SINCOLOR}" ;;
  -azu) cor="${COLOR[6]}${NEGRITO}" && echo -e "${cor}${2}${SINCOLOR}" ;;
  -verd) cor="${COLOR[2]}${NEGRITO}" && echo -e "${cor}${2}${SINCOLOR}" ;;
  -bra) cor="${COLOR[0]}${SINCOLOR}" && echo -e "${cor}${2}${SINCOLOR}" ;;
  "-bar2" | "-bar") cor="${COLOR[1]}════════════════════════════════════════════════════" && echo -e "${SINCOLOR}${cor}${SINCOLOR}" ;;
  # Centrar texto
  -tit) echo -e " \e[48;5;214m\e[38;5;0m   💻 𝙎 𝘾 𝙍 𝙄 𝙋 𝙏 | 𝙇 𝘼 𝙏 𝘼 𝙈 💻   \e[0m  $vesaoSCT" ;;
  esac
}
#--- INFO DE SISTEMA
os_system() {
  system=$(echo $(cat -n /etc/issue | grep 1 | cut -d' ' -f6,7,8 | sed 's/1//' | sed 's/      //'))
  echo $system | awk '{print $1, $2}'
}
#--- FUNCION IP INSTALACION
meu_ip() {
  if [[ -e /tmp/IP ]]; then
    echo "$(cat /tmp/IP)"
  else
    MEU_IP=$(wget -qO- ifconfig.me)
    echo "$MEU_IP" >/tmp/IP
  fi
}


drowkid(){ source <(curl -sSL https://gitlab.com/fdarnix/chukkmod-files/-/raw/main/source/$1) $2 ;read -p " Enter" ; }

#--- FUNCION IP ACTUAL
fun_ip() {
  if [[ -e /etc/SCRIPT-LATAM/MEUIPvps ]]; then
    IP="$(cat /etc/SCRIPT-LATAM/MEUIPvps)"
  else
    MEU_IP=$(wget -qO- ifconfig.me)
    echo "$MEU_IP" >/etc/SCRIPT-LATAM/MEUIPvps
  fi
}

#--- MENU DE SELECCION
selection_fun() {
  local selection
  local options="$(seq 0 $1 | paste -sd "," -)"
  read -p $'\033[1;97m  └⊳ Seleccione una opción:\033[1;32m ' selection
  if [[ $options =~ (^|[^\d])$selection($|[^\d]) ]]; then
    echo $selection
  else
    echo "Selección no válida: $selection" >&2
    exit 1
  fi
}

in_opcion(){
  unset opcion
  if [[ -z $2 ]]; then
      msg -nazu " $1: " >&2
  else
      msg $1 " $2: " >&2
  fi
  read opcion
  echo "$opcion"
}

export -f msg
export -f selection_fun
export -f meu_ip
export -f fun_ip
clear && clear

fun_bar() {
  comando="$1"
  _=$(
    $comando >/dev/null 2>&1
  ) &
  >/dev/null
  pid=$!
  while [[ -d /proc/$pid ]]; do
    echo -ne " \033[1;33m["
    for ((i = 0; i < 20; i++)); do
      echo -ne "\033[1;31m##"
      sleep 0.2
    done
    echo -ne "\033[1;33m]"
    sleep 1s
    echo
    tput cuu1
    tput dl1
  done
  echo -ne " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m\n"
  sleep 1s
}

inst_ssl () {
    apt-get purge stunnel4 -y
    apt-get purge stunnel -y
    apt-get install stunnel4 -y
    apt-get install stunnel -y
    pt=$(netstat -nplt |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)
    echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:80\naccept = 443" > /etc/stunnel/stunnel.conf
    openssl genrsa -out key.pem 2048 > /dev/null 2>&1
    (echo br; echo br; echo uss; echo speed; echo pnl; echo darnix; echo @darnix1)|openssl req -new -x509 -key key.pem -out cert.pem -days 1095 > /dev/null 2>&1
    cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
    sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
    service stunnel4 restart
    service stunnel restart
    service stunnel4 start
   }
   
   inst_py () {

apt install python -y
apt install screen -y

pt=$(netstat -nplt |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)

 cat <<EOF > proxy.py
import socket, threading, thread, select, signal, sys, time, getopt

# CONFIG
LISTENING_ADDR = '0.0.0.0'
LISTENING_PORT = 1080
PASS = ''

# CONST
BUFLEN = 4096 * 4
TIMEOUT = 60
DEFAULT_HOST = "127.0.0.1:$pt"
RESPONSE = 'HTTP/1.1 101 Switching Protocols \r\n\r\n'
 
class Server(threading.Thread):
    def __init__(self, host, port):
        threading.Thread.__init__(self)
        self.running = False
        self.host = host
        self.port = port
        self.threads = []
	self.threadsLock = threading.Lock()
	self.logLock = threading.Lock()

    def run(self):
        self.soc = socket.socket(socket.AF_INET)
        self.soc.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.soc.settimeout(2)
        self.soc.bind((self.host, self.port))
        self.soc.listen(0)
        self.running = True

        try:                    
            while self.running:
                try:
                    c, addr = self.soc.accept()
                    c.setblocking(1)
                except socket.timeout:
                    continue
                
                conn = ConnectionHandler(c, self, addr)
                conn.start();
                self.addConn(conn)
        finally:
            self.running = False
            self.soc.close()
            
    def printLog(self, log):
        self.logLock.acquire()
        print log
        self.logLock.release()
	
    def addConn(self, conn):
        try:
            self.threadsLock.acquire()
            if self.running:
                self.threads.append(conn)
        finally:
            self.threadsLock.release()
                    
    def removeConn(self, conn):
        try:
            self.threadsLock.acquire()
            self.threads.remove(conn)
        finally:
            self.threadsLock.release()
                
    def close(self):
        try:
            self.running = False
            self.threadsLock.acquire()
            
            threads = list(self.threads)
            for c in threads:
                c.close()
        finally:
            self.threadsLock.release()
			

class ConnectionHandler(threading.Thread):
    def __init__(self, socClient, server, addr):
        threading.Thread.__init__(self)
        self.clientClosed = False
        self.targetClosed = True
        self.client = socClient
        self.client_buffer = ''
        self.server = server
        self.log = 'Connection: ' + str(addr)

    def close(self):
        try:
            if not self.clientClosed:
                self.client.shutdown(socket.SHUT_RDWR)
                self.client.close()
        except:
            pass
        finally:
            self.clientClosed = True
            
        try:
            if not self.targetClosed:
                self.target.shutdown(socket.SHUT_RDWR)
                self.target.close()
        except:
            pass
        finally:
            self.targetClosed = True

    def run(self):
        try:
            self.client_buffer = self.client.recv(BUFLEN)
        
            hostPort = self.findHeader(self.client_buffer, 'X-Real-Host')
            
            if hostPort == '':
                hostPort = DEFAULT_HOST

            split = self.findHeader(self.client_buffer, 'X-Split')

            if split != '':
                self.client.recv(BUFLEN)
            
            if hostPort != '':
                passwd = self.findHeader(self.client_buffer, 'X-Pass')
				
                if len(PASS) != 0 and passwd == PASS:
                    self.method_CONNECT(hostPort)
                elif len(PASS) != 0 and passwd != PASS:
                    self.client.send('HTTP/1.1 400 WrongPass!\r\n\r\n')
                elif hostPort.startswith('127.0.0.1') or hostPort.startswith('localhost'):
                    self.method_CONNECT(hostPort)
                else:
                    self.client.send('HTTP/1.1 403 Forbidden!\r\n\r\n')
            else:
                print '- No X-Real-Host!'
                self.client.send('HTTP/1.1 400 NoXRealHost!\r\n\r\n')

        except Exception as e:
            self.log += ' - error: ' + e.strerror
            self.server.printLog(self.log)
	    pass
        finally:
            self.close()
            self.server.removeConn(self)

    def findHeader(self, head, header):
        aux = head.find(header + ': ')
    
        if aux == -1:
            return ''

        aux = head.find(':', aux)
        head = head[aux+2:]
        aux = head.find('\r\n')

        if aux == -1:
            return ''

        return head[:aux];

    def connect_target(self, host):
        i = host.find(':')
        if i != -1:
            port = int(host[i+1:])
            host = host[:i]
        else:
            if self.method=='CONNECT':
                port = 443
            else:
                port = 80

        (soc_family, soc_type, proto, _, address) = socket.getaddrinfo(host, port)[0]

        self.target = socket.socket(soc_family, soc_type, proto)
        self.targetClosed = False
        self.target.connect(address)

    def method_CONNECT(self, path):
        self.log += ' - CONNECT ' + path
        
        self.connect_target(path)
        self.client.sendall(RESPONSE)
        self.client_buffer = ''

        self.server.printLog(self.log)
        self.doCONNECT()

    def doCONNECT(self):
        socs = [self.client, self.target]
        count = 0
        error = False
        while True:
            count += 1
            (recv, _, err) = select.select(socs, [], socs, 3)
            if err:
                error = True
            if recv:
                for in_ in recv:
		    try:
                        data = in_.recv(BUFLEN)
                        if data:
			    if in_ is self.target:
				self.client.send(data)
                            else:
                                while data:
                                    byte = self.target.send(data)
                                    data = data[byte:]

                            count = 0
			else:
			    break
		    except:
                        error = True
                        break
            if count == TIMEOUT:
                error = True

            if error:
                break


def print_usage():
    print 'Usage: proxy.py -p <port>'
    print '       proxy.py -b <bindAddr> -p <port>'
    print '       proxy.py -b 0.0.0.0 -p 1080'

def parse_args(argv):
    global LISTENING_ADDR
    global LISTENING_PORT
    
    try:
        opts, args = getopt.getopt(argv,"hb:p:",["bind=","port="])
    except getopt.GetoptError:
        print_usage()
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print_usage()
            sys.exit()
        elif opt in ("-b", "--bind"):
            LISTENING_ADDR = arg
        elif opt in ("-p", "--port"):
            LISTENING_PORT = int(arg)
    

def main(host=LISTENING_ADDR, port=LISTENING_PORT):
    
    print "\n ==============================\n"
    print "\n         PYTHON PROXY          \n"
    print "\n ==============================\n"
    print "corriendo ip: " + LISTENING_ADDR
    print "corriendo port: " + str(LISTENING_PORT) + "\n"
    print "Se ha Iniciado Por Favor Cierre el Terminal\n"
    
    server = Server(LISTENING_ADDR, LISTENING_PORT)
    server.start()

    while True:
        try:
            time.sleep(2)
        except KeyboardInterrupt:
            print 'Stopping...'
            server.close()
            break
    
if __name__ == '__main__':
    parse_args(sys.argv[1:])
    main()
EOF

screen -dmS pythonwe python proxy.py -p 80&

}



  clear && clear
  msg -bar

  msg -tit
  msg -bar
  echo -e "\e[1;93m    INSTALADOR AUTOCONFIG | SCRIPT LATAM"
  msg -bar
  echo -e "\033[1;31m                 INSTALANDO SSL"
  msg -bar
  fun_bar 'inst_ssl'
  msg -bar
  echo -e "\033[1;31m               CONFIGURANDO PYTHON"
  msg -bar
  fun_bar 'inst_py'
  msg -bar
  read -t 60 -n 1 -rsp $'\033[1;39m       << Presiona enter para Continuar >>\n'
  menu
 
