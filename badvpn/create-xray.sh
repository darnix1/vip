#!/bin/bash
COLOR1='\033[0;35m'
WH='\033[0;39m'
BOT_TOKEN=$(cat /etc/bot_telegram 2>/dev/null)
CHAT_ID=$(cat /etc/user_telegram 2>/dev/null)

# Función para notificar por Telegram
notify_telegram() {
    local message="$1"
    if [ -n "$BOT_TOKEN" ] && [ -n "$CHAT_ID" ]; then
        curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
            -d "chat_id=${CHAT_ID}" \
            -d "text=$message" \
            -d "parse_mode=HTML" > /dev/null
    fi
}

# Función para generar UUID
generate_uuid() {
    cat /proc/sys/kernel/random/uuid
}

# Configurar usuario en Xray
add_xray_config() {
    local section=$1
    local content=$2
    sed -i "/#$section\$/a\\#&@ $user $exp\n$content" /usr/local/etc/xray/config/04_inbounds.json
}

# Solicitar datos del usuario
read -p "Masukan username: " user
read -p "Masukan masa aktif (hari): " masaaktif
read -p "Masukan limit data (GB): " data_limit_gb

# Validaciones
[[ ! "$masaaktif" =~ ^[0-9]+$ ]] && echo "Masa aktif harus angka!" && exit 1
[[ ! "$data_limit_gb" =~ ^[0-9]+(\.[0-9]+)?$ ]] && echo "Limit data harus angka!" && exit 1

exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
domain=$(cat /usr/local/etc/xray/dns/domain)
uuid=$(generate_uuid)
pwtr=$(openssl rand -hex 4)

# Registrar límite
mkdir -p /etc/xray
echo "$user,$data_limit_gb,$exp" >> /etc/xray/user_limits.csv


# Notificar creación
notify_telegram "✅ <b>Usuario Creado:</b> $user\n📊 <b>Límite:</b> $data_limit_gb GB\n⏳ <b>Expira:</b> $exp"

echo -e "${COLOR1}Usuario $user creado con éxito!${WH}"
# Menambahkan Konfigurasi ke File Xray
add_xray_config "xtls" "},{\"flow\": \"xtls-rprx-vision\",\"id\": \"$uuid\",\"email\": \"$user\""
add_xray_config "vless" "},{\"id\": \"$uuid\",\"email\": \"$user\""
add_xray_config "universal" "},{\"id\": \"$uuid\",\"email\": \"$user\""
add_xray_config "vmess" "},{\"id\": \"$uuid\",\"email\": \"$user\""
add_xray_config "trojan" "},{\"password\": \"$pwtr\",\"email\": \"$user\""

ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
REG=$(cat /usr/local/etc/xray/region)

# Fungsi untuk membuat tautan Vmess
create_vmess_link() {
    local version="2"
    local ps=$1
    local port=$2
    local net=$3
    local path=$4
    local tls=$5
    cat <<EOF | base64 -w 0
{
"v": "$version",
"ps": "$ps",
"add": "$domain",
"port": "$port",
"id": "$uuid",
"aid": "0",
"net": "$net",
"path": "$path",
"type": "none",
"host": "$domain",
"tls": "$tls"
}
EOF
}

# Membuat Tautan Vmess
vmesslink1="vmess://$(create_vmess_link "vmess-ws-tls" "443" "ws" "/vmess-ws" "tls")"
vmesslink2="vmess://$(create_vmess_link "vmess-ws-ntls" "80" "ws" "/vmess-ws" "none")"
vmesslink3="vmess://$(create_vmess_link "vmess-hup-tls" "443" "httpupgrade" "/vmess-hup" "tls")"
vmesslink4="vmess://$(create_vmess_link "vmess-hup-ntls" "80" "httpupgrade" "/vmess-hup" "none")"
vmesslink5="vmess://$(create_vmess_link "vmess-grpc" "443" "grpc" "vmess-grpc" "tls")"

# Membuat Tautan Vless
vlesslink1="vless://$uuid@$domain:443?path=/vless-ws&security=tls&encryption=none&host=$domain&type=ws&sni=$domain#vless-ws-tls"
vlesslink2="vless://$uuid@$domain:80?path=/vless-ws&security=none&encryption=none&host=$domain&type=ws#vless-ws-ntls"
vlesslink3="vless://$uuid@$domain:443?path=/vless-hup&security=tls&encryption=none&host=$domain&type=httpupgrade&sni=$domain#vless-hup-tls"
vlesslink4="vless://$uuid@$domain:80?path=/vless-hup&security=none&encryption=none&host=$domain&type=httpupgrade#vless-hup-ntls"
vlesslink5="vless://$uuid@$domain:443?security=tls&encryption=none&headerType=gun&type=grpc&serviceName=vless-grpc&sni=$domain#vless-grpc"
vlesslink6="vless://$uuid@$domain:443?security=tls&encryption=none&headerType=none&type=tcp&sni=$domain&flow=xtls-rprx-vision#vless-vision"

# Membuat Tautan Trojan
trojanlink1="trojan://$pwtr@$domain:443?path=/trojan-ws&security=tls&host=$domain&type=ws&sni=$domain#trojan-ws-tls"
trojanlink2="trojan://$pwtr@$domain:80?path=/trojan-ws&security=none&host=$domain&type=ws#trojan-ws-ntls"
trojanlink3="trojan://$pwtr@$domain:443?path=/trojan-hup&security=tls&host=$domain&type=httpupgrade&sni=$domain#trojan-hup-tls"
trojanlink4="trojan://$pwtr@$domain:80?path=/trojan-hup&security=none&host=$domain&type=httpupgrade#trojan-hup-ntls"
trojanlink5="trojan://$pwtr@$domain:443?security=tls&type=grpc&mode=multi&serviceName=trojan-grpc&sni=$domain#trojan-grpc"
trojanlink6="trojan://$pwtr@$domain:443?security=tls&type=tcp&sni=$domain#trojan-tcp-tls"

# Membuat Tautan Shadowsocks
encode_ss() {
    echo -n "$1:$2" | base64 -w 0
}

# Menulis Log ke File
cat > /var/www/html/xray/xray-$user.html << END
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DARNIX</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            color: #333;
            margin: 0;
            padding: 20px;
            line-height: 1.6;
        }
        header, footer {
            background: linear-gradient(135deg, #4CAF50, #36a24f);
            color: white;
            padding: 15px 20px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: black; /* Cambio de color a negro */
            font-weight: 600;
            margin: 0;
        }
        h2, h3 {
            color: #4CAF50;
            font-weight: 600;
        }
        h2 {
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-size: 24px;
            cursor: pointer;
            transition: color 0.3s ease;
        }
        h2:hover {
            color: #36a24f;
        }
        pre {
            background: #1e1e1e;
            color: #f8f8f2;
            padding: 15px;
            border-radius: 10px;
            overflow-x: auto;
            font-family: "Courier New", Courier, monospace;
            margin-bottom: 20px;
            border: 2px solid #4CAF50;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .section {
            margin-bottom: 40px;
        }
        hr {
            display: none;
            border: none;
            border-top: 2px solid #4CAF50;
            margin: 40px 0;
        }
        .link-section {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .link-box {
            flex: 1;
            min-width: 300px;
            max-width: 100%;
            padding: 20px;
            border: 2px solid #4CAF50;
            border-radius: 10px;
            background: #ffffff;
            margin-bottom: 20px;
            box-sizing: border-box;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .link-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2);
        }
        button, .copy-button {
            display: inline-block;
            padding: 10px 20px;
            border: none;
            background: linear-gradient(135deg, #4CAF50, #36a24f);
            color: white;
            border-radius: 25px;
            cursor: pointer;
            margin: 5px 0;
            font-weight: 600;
            transition: background 0.3s ease;
        }
        button:hover {
            background: linear-gradient(135deg, #36a24f, #2b8a3e);
        }
        .notification {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, #4CAF50, #36a24f);
            color: white;
            padding: 15px 25px;
            border-radius: 25px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            animation: fadeInOut 2s ease-in-out;
        }
        @keyframes fadeInOut {
            0%, 100% { opacity: 0; }
            10%, 90% { opacity: 1; }
        }
        footer {
            font-size: 14px;
        }
        .accordion-content {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.5s ease-out;
        }
        .accordion-content.show {
            max-height: 1000px;
        }
        @media (prefers-color-scheme: dark) {
            body {
                background: linear-gradient(135deg, #121212, #1e1e1e);
                color: #e0e0e0;
            }
            header, footer {
                background: linear-gradient(135deg, #4CAF50, #36a24f);
                color: white;
            }
            .link-box {
                background: #333;
                border-color: #4CAF50;
            }
            pre {
                background: #1e1e1e;
                border-color: #4CAF50;
            }
            button, .copy-button {
                background: linear-gradient(135deg, #4CAF50, #36a24f);
                color: white;
            }
        }
        @media (max-width: 768px) {
            h2 {
                font-size: 20px;
            }
            .link-box {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1 style="color: black;">DARNIX</h1> <!-- Título en negro -->
    </header>
    <div class="section">
        <h2><i class="fas fa-server"></i> Información del Servidor</h2>
        <pre>Proveedor de Servicios de Internet : ${ISP}
Región         : ${REG}
Ciudad         : ${CITY}
Puerto TLS/HTTPS : 443
Puerto HTTP      : 80
Protocolos       : XTLS-Vision, TCP TLS, HTTPupgrade, Websocket, gRPC
Fecha de Expiración : ${exp}</pre>
    </div>
    <hr>
    <!-- Enlaces Vmess -->
    <div class="section">
        <h2 onclick="toggleAccordion(this)"><i class="fas fa-link"></i> Enlaces Vmess</h2>
        <div class="accordion-content">
            <div class="link-section">
                <div class="link-box">
                    <h3>Websocket TLS</h3>
                    <pre id="vmess-ws-tls">${vmesslink1}</pre>
                    <button onclick="copyToClipboard('vmess-ws-tls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>Websocket sin TLS</h3>
                    <pre id="vmess-ws-ntls">${vmesslink2}</pre>
                    <button onclick="copyToClipboard('vmess-ws-ntls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>HTTPupgrade TLS</h3>
                    <pre id="vmess-hup-tls">${vmesslink3}</pre>
                    <button onclick="copyToClipboard('vmess-hup-tls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>HTTPupgrade sin TLS</h3>
                    <pre id="vmess-hup-ntls">${vmesslink4}</pre>
                    <button onclick="copyToClipboard('vmess-hup-ntls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>gRPC</h3>
                    <pre id="vmess-grpc">${vmesslink5}</pre>
                    <button onclick="copyToClipboard('vmess-grpc')">Copiar</button>
                </div>
            </div>
        </div>
    </div>
    <hr>
    <!-- Enlaces Vless -->
    <div class="section">
        <h2 onclick="toggleAccordion(this)"><i class="fas fa-link"></i> Enlaces Vless</h2>
        <div class="accordion-content">
            <div class="link-section">
                <div class="link-box">
                    <h3>Websocket TLS</h3>
                    <pre id="vless-ws-tls">${vlesslink1}</pre>
                    <button onclick="copyToClipboard('vless-ws-tls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>Websocket sin TLS</h3>
                    <pre id="vless-ws-ntls">${vlesslink2}</pre>
                    <button onclick="copyToClipboard('vless-ws-ntls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>HTTPupgrade TLS</h3>
                    <pre id="vless-hup-ntls">${vlesslink3}</pre>
                    <button onclick="copyToClipboard('vless-hup-ntls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>HTTPupgrade sin TLS</h3>
                    <pre id="vless-hup-ntls">${vlesslink4}</pre>
                    <button onclick="copyToClipboard('vless-hup-ntls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>XTLS-RPRX-VISION</h3>
                    <pre id="vless-vision">${vlesslink6}</pre>
                    <button onclick="copyToClipboard('vless-vision')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>gRPC</h3>
                    <pre id="vless-grpc">${vlesslink5}</pre>
                    <button onclick="copyToClipboard('vless-grpc')">Copiar</button>
                </div>
            </div>
        </div>
    </div>
    <hr>
    <!-- Enlaces Trojan -->
    <div class="section">
        <h2 onclick="toggleAccordion(this)"><i class="fas fa-link"></i> Enlaces Trojan</h2>
        <div class="accordion-content">
            <div class="link-section">
                <div class="link-box">
                    <h3>Websocket TLS</h3>
                    <pre id="trojan-ws-tls">${trojanlink1}</pre>
                    <button onclick="copyToClipboard('trojan-ws-tls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>Websocket sin TLS</h3>
                    <pre id="trojan-ws-ntls">${trojanlink2}</pre>
                    <button onclick="copyToClipboard('trojan-ws-ntls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>HTTPupgrade TLS</h3>
                    <pre id="trojan-hup-tls">${trojanlink3}</pre>
                    <button onclick="copyToClipboard('trojan-hup-tls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>HTTPupgrade sin TLS</h3>
                    <pre id="trojan-hup-ntls">${trojanlink4}</pre>
                    <button onclick="copyToClipboard('trojan-hup-ntls')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>TCP TLS</h3>
                    <pre id="trojan-tcp">${trojanlink5}</pre>
                    <button onclick="copyToClipboard('trojan-tcp')">Copiar</button>
                </div>
                <div class="link-box">
                    <h3>gRPC</h3>
                    <pre id="trojan-grpc">${trojanlink6}</pre>
                    <button onclick="copyToClipboard('trojan-grpc')">Copiar</button>
                </div>
            </div>
        </div>
    </div>
    <div class="notification" id="notification">¡Copiado al portapapeles!</div>
    <footer>
        <p>Darnix Xray VPN &copy; 2024</p>
    </footer>
    <script>
        function copyToClipboard(elementId) {
            var codeElement = document.getElementById(elementId);
            var range = document.createRange();
            range.selectNodeContents(codeElement);
            var selection = window.getSelection();
            selection.removeAllRanges();
            selection.addRange(range);
            try {
                document.execCommand('copy');
                showNotification();
            } catch (err) {
                console.error('Error al copiar el texto: ', err);
            }
        }
        function showNotification() {
            var notification = document.getElementById('notification');
            notification.style.display = 'block';
            setTimeout(function() {
                notification.style.display = 'none';
            }, 2000);
        }
        function toggleAccordion(element) {
            var content = element.nextElementSibling;
            if (content.classList.contains('show')) {
                content.classList.remove('show');
                content.style.maxHeight = null;
            } else {
                var allContents = document.querySelectorAll('.accordion-content');
                allContents.forEach(function(c) {
                    c.classList.remove('show');
                    c.style.maxHeight = null;
                });
                content.classList.add('show');
                content.style.maxHeight = content.scrollHeight + 'px';
            }
        }
    </script>
</body>
</html>
END

# Restart Xray Service
systemctl restart xray


# Clear Screen
clear

# Menampilkan Informasi ke Pengguna
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    ----- [ All Xray ] -----              " | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${COLOR1}ISP            : ${WH}$ISP" | tee -a /user/xray-$user.log
echo -e "${COLOR1}Region         : ${WH}$REG" | tee -a /user/xray-$user.log
echo -e "${COLOR1}City           : ${WH}$CITY" | tee -a /user/xray-$user.log
echo -e "${COLOR1}Port TLS/HTTPS : ${WH}443" | tee -a /user/xray-$user.log
echo -e "${COLOR1}Port HTTP      : ${WH}80" | tee -a /user/xray-$user.log
echo -e "${COLOR1}Transport      : ${WH}XTLS-Vision, TCP TLS, Websocket, HTTPupgrade, gRPC" | tee -a /user/xray-$user.log
echo -e "${COLOR1}Expired On     : ${WH}$exp" | tee -a /user/xray-$user.log
echo -e "${COLOR1}Link / Web     : ${WH}https://$domain/xray/xray-$user.html" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    ----- [ Vmess Link ] -----             " | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link WS TLS    : ${WH}$vmesslink1" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link WS nTLS   : ${WH}$vmesslink2" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link HUP TLS   : ${WH}$vmesslink3" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link HUP nTLS  : ${WH}$vmesslink4" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link gRPC      : ${WH}$vmesslink5" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${COLOR1} " | tee -a /user/xray-$user.log
echo -e "${COLOR1} " | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    ----- [ Vless Link ] -----             " | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link WS TLS    : ${WH}$vlesslink1" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link WS nTLS   : ${WH}$vlesslink2" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link HUP TLS   : ${WH}$vlesslink3" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link HUP nTLS  : ${WH}$vlesslink4" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link gRPC      : ${WH}$vlesslink5" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link XTLS-Vision : ${WH}$vlesslink6" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${COLBG1} " | tee -a /user/xray-$user.log
echo -e "${COLOR1} " | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    ----- [ Trojan Link ] -----             " | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link WS TLS    : ${WH}$trojanlink1" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link WS nTLS   : ${WH}$trojanlink2" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link HUP TLS   : ${WH}$trojanlink3" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link HUP nTLS  : ${WH}$trojanlink4" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link gRPC      : ${WH}$trojanlink5" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${WH}    Link TCP TLS   : ${WH}$trojanlink6" | tee -a /user/xray-$user.log
echo -e "${COLOR1}————————————————————————" | tee -a /user/xray-$user.log
echo -e "${COLOR1} " | tee -a /user/xray-$user.log
echo -e "${COLOR1} " | tee -a /user/xray-$user.log

# ... (tu código existente)

# ==============================================
# AUTOMATIZAR CRONJOB (si no existe)
# ==============================================

#CRON_JOB="*/30 * * * * /usr/local/bin/check_xray_limits.sh >> /var/log/xray_limits.log 2>&1"
#CRON_FILE="/var/spool/cron/crontabs/root"

# Verificar si el cronjob ya existe
#if ! sudo crontab -l | grep -q "check_xray_limits.sh"; then
    # Configurar cronjob automáticamente
    #(sudo crontab -l 2>/dev/null; echo "$CRON_JOB") | sudo crontab -
    
    # Crear archivo de log y dar permisos
    #sudo touch /var/log/xray_limits.log
    #sudo chmod 644 /var/log/xray_limits.log
    
    #echo -e "${COLOR1}[✓] CronJob configurado automáticamente.${WH}"
#else
    #echo -e "${COLOR1}[i] CronJob ya estaba configurado.${WH}"
#fi


BOT_TOKEN=$(cat /etc/bot_telegram)
CHAT_ID=$(cat /etc/user_telegram)
LOG_FILE="/user/xray-$user.log"

message=$(cat <<EOF
\`\`\`DETAIL-AKUN
*——————————————————————————————————————————————————*
            *----- [ Detail Akun ] -----*
*——————————————————————————————————————————————————*
User           : $user
ISP            : $ISP
Region         : $REG
City           : $CITY
Port TLS/HTTPS : 443
Port HTTP      : 80
Transport      : XTLS-Vision, TCP TLS, Websocket, HTTPupgrade, gRPC
Expired On     : $exp
*——————————————————————————————————————————————————*\`\`\`
\`\`\`VMESS-WSTLS
vmess://$(create_vmess_link "vmess-ws-tls" "443" "ws" "/vmess-ws" "tls")\`\`\`
\`\`\`VMESS-WSNTLS
vmess://$(create_vmess_link "vmess-ws-ntls" "80" "ws" "/vmess-ws" "none")\`\`\`
\`\`\`VMESS-GRPC
vmess://$(create_vmess_link "vmess-grpc" "443" "grpc" "vmess-grpc" "tls")\`\`\`
All Protocol   : https://$domain/xray/xray-$user.html
EOF
)

curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d "chat_id=$CHAT_ID" \
    -d "text=$message" \
    -d "parse_mode=Markdown" \
    -d "disable_notification=false" > /dev/null 2>&1

if [ -f "$LOG_FILE" ]; then
    # Mengunggah file log ke Telegram
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
        -F chat_id="$CHAT_ID" \
        -F document=@"$LOG_FILE" \
        -F caption="DETAIL ACCOUNT FOR [ $user ]" \
        -F disable_notification=false > /dev/null 2>&1
else
    echo "File log tidak ditemukan: $LOG_FILE"
fi
read -n 1 -s -r -p "Press any key to go back to menu"
clear
Sc_Credit
