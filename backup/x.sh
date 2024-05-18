#!/bin/bash
if [[ ! -e /usr/games/msg ]]; then
	wget -O /usr/games/msg "https://gitea.com/drowkid01/scriptdk1/raw/branch/main/msg-bar/msg" &> /dev/null
        chmod +x /usr/games/msg
fi

source msg
mportas() {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}

fun-ngi(){
local ngiconf=( [0]='/etc/nginx/conf.d/default.conf' [1]='/etc/nginx/nginx.conf' )
newname=$(cat /dev/urandom | tr -dc '[:alnum:]' | head -c 10)
  [[ -e ${ngiconf[0]} ]] && {
	mv -f ${ngiconf[0]} /etc/nginx/conf.d/${newname}.conf
  }

while read -p $'\e[1;31mIngrese el puerto para nginx: ' portngi ; do
	if [[ -z $portngi ]]; then
		return $?
	else
		if [[ $(mportas|grep "${portngi}") ]]; then
			msg -verm "PUERTO ${portngi} YA USADO"&&unset portngi&&tput cuu1&&tput dl1
		else
			portngi=$(echo $portngi|tr -d '[[:alpha:]]'|tr -d '[[:space:]]')&&break
		fi
	fi
done
[[ $(dpkg --get-selections|grep 'apache2') ]] && apt purge apache2 -y
[[ $(dpkg --get-selections|grep 'apache') ]] && apt purge apache -y
[[ $(dpkg --get-selections|grep 'apache2-bin') ]] && apt purge apache2-bin -y
clear
cat <<< '╻┏┓╻┏━┓╺┳╸┏━┓╻  ┏━┓┏┓╻╺┳┓┏━┓   ┏┓╻┏━╸╻┏┓╻╻ ╻
┃┃┗┫┗━┓ ┃ ┣━┫┃  ┣━┫┃┗┫ ┃┃┃ ┃   ┃┗┫┃╺┓┃┃┗┫┏╋┛
╹╹ ╹┗━┛ ╹ ╹ ╹┗━╸╹ ╹╹ ╹╺┻┛┗━┛   ╹ ╹┗━┛╹╹ ╹╹ ╹'
msg -bar
apt-get install nginx -y
killall nginx &> /dev/null
	cat >> ${ngiconf[0]} <<- eof
		server {
		   listen       ${portngi};
		   server_name  localhost;

		    #access_log  /var/log/nginx/host.access.log  main;

		    location / {
		        root   /usr/share/nginx/html;
		        index  index.html index.htm;
		    }

		    #error_page  404              /404.html;

		    # redirect server error pages to the static page /50x.html
		    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
		    #
		    location ~ \.php$ {
		        proxy_pass   http://127.0.0.1:443;
		    }

	    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
	    #
	    #location ~ \.php$ {
	    #    root           html;
	    #    fastcgi_pass   127.0.0.1:9000;
	    #    fastcgi_index  index.php;
	    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
	    #    include        fastcgi_params;
	    #}

	    # deny access to .htaccess files, if Apache's document root
	    # concurs with nginx's one
	    #
	    #location ~ /\.ht {
	    #    deny  all;
	    #}
	}
	eof
	wget -O /etc/nginx/nginx.conf https://gitea.com/drowkid01/scriptdk1/raw/branch/main/conf/nginx.conf &> /dev/null
	killall nginx
	pkill -f 80&&pkill -f nginx
	systemctl enable nginx
		(
	systemctl start nginx &> /dev/null
	systemctl stop nginx &> /dev/null
	systemctl daemon-reload &> /dev/null
	nginx &> /dev/null
	systemctl restart nginx &> /dev/null
	nginx -c /etc/nginx/nginx.conf &> /dev/null
		) && status=$? || status=$?
	killall nginx
	nginx -t
	nginx
	msg -bar
	echo -e "\e[1;32m	[✓] NGINX INSTALADO CORRECTAMENTE [✓]"
}

[[ ! -d /etc/adm-lite/conf.d ]] && mkdir -p /etc/adm-lite/conf.d
clear
cat <<< '┏┓╻┏━╸╻┏┓╻╻ ╻   ┏┳┓┏━╸┏┓╻╻ ╻
┃┗┫┃╺┓┃┃┗┫┏╋┛╺━╸┃┃┃┣╸ ┃┗┫┃ ┃
╹ ╹┗━┛╹╹ ╹╹ ╹   ╹ ╹┗━╸╹ ╹┗━┛'
msg -bar
if [[ ! $(mportas|grep -v grep|grep 'nginx') ]]; then
	menu_func 'INSTALAR NGINX'
else
	menu_func 'AÑADIR PUERTO NGINX' 'ELIMINAR PUERTO NGINX' '-vm DESINSTALAR NGINX'
fi
back
case `selection_fun 5` in
  0)break;;
  1)fun-ngi;;
  2)
	nginxport=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" |grep "nginx"|awk '{print $9}'|awk -F ":" '{print $2}'|xargs)
	echo -e "\e[1;93mPUERTO NGINX: \e[1;97m${nginxport}"
	msg -bar
	while read -p $'\e[1;31mIngrese el puerto que desea eliminar: ' portngi ; do
		if [[ -z $portngi ]]; then
			return $?
		else
			if [[ $(mportas|grep "${portngi}") ]]; then
				portngi=$(echo $portngi|tr -d '[[:alpha:]]'|tr -d '[[:space:]]')&&break
			else
				msg -verm "PUERTO ${portngi} YA USADO"&&unset portngi&&tput cuu1&&tput dl1
			fi
		fi
	done
	killall nginx
	systemctl stop nginx
	for file in `ls /etc/nginx/conf.d`; do
		if [[ $(cat ${file}|grep "${portngi}") ]]; then
			rm -f $file
			systemctl daemon-reload&&systemctl restart nginx
		else
			unset var
		fi
	done;;
  3)
	systemctl stop nginx
	systemctl disable nginx
	systemctl daemon-reload
	apt purge nginx
	rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d/*
	apt autoremove
	apt clean
	killall nginx
	msg -bar&&msg -verm 'NGINX DESINSTALADO';;
esac
enter
