#!/bin/bash
#pilihlah salah satu server di bawah ini
#kumpulan domain
clear
biru="\e[36m"
merah="\033[31m"
hijau="\e[92;1m"
NC='\e[0m'
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│$NC [${biru}01$NC]$NC alawistore.my.id                    $NC$biru│$NC"
echo -e "$biru│$NC [${biru}02$NC]$NC alawistore.biz.id                   $NC$biru│$NC"
echo -e "$biru│$NC [${biru}03$NC]$NC alawivpn.cloud                      $NC$biru│$NC"
echo -e "$biru│$NC [${biru}04$NC]$NC cakdayat.my.id                      $NC$biru│$NC"
echo -e "$biru│$NC [${biru}05$NC]$NC petapan.my.id                       $NC$biru│$NC"
echo -e "$biru│$NC [${biru}06$NC]$NC sayasantri.my.id                    $NC$biru│$NC"
echo -e "$biru│$NC [${biru}07$NC]$NC serverssh.biz.id                    $NC$biru│$NC"
echo -e "$biru│$NC [${biru}08$NC]$NC sshserver.my.id                     $NC$biru│$NC"
echo -e "$biru│$NC [${biru}09$NC]$NC udpserver.my.id                     $NC$biru│$NC"
echo -e "$biru│$NC [${biru}10$NC]$NC vmesserver.my.id                    $NC$biru│$NC"
echo -e "$biru│$NC [${biru}11$NC]$NC vpnbagus.my.id                      $NC$biru│$NC"
echo -e "$biru│$NC [${biru}12$NC]$NC vpnssh.biz.id                       $NC$biru│$NC"
echo -e "$biru│$NC [${biru}13$NC]$NC vpssantri.my.id                     $NC$biru│$NC"
echo -e "$biru│$NC [${biru}14$NC]$NC vpsvpn.my.id                        $NC$biru│$NC"
echo -e "$biru│$NC [${biru}15$NC]$NC wush.my.id                          $NC$biru│$NC"
echo -e "$biru│$NC [${biru}16$NC]$NC wussh.my.id                         $NC$biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
read -rp "pilih salah satu (1-16): " host
echo -e ""
#domain 1
if [ $host -eq 1 ]
then
  clear
DOMAIN1=alawistore.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN1}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN1=${sub1}.${DOMAIN1}
SUB_DOMAIN01=zoomcares.zoom.us.${sub1}.${DOMAIN1}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN1}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN1}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN1}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN1}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN1}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN01}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN1}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN01}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN01}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN01}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN1}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 2
elif [ $host -eq 2 ]
then
  clear
DOMAIN2=alawistore.biz.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN2}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN2=${sub1}.${DOMAIN2}
SUB_DOMAIN02=zoomcares.zoom.us.${sub1}.${DOMAIN2}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN2}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN2}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN2}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN2}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN2}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN02}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN2}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN02}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN02}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN02}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN2}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 3
elif [ $host -eq 3 ]
then
  clear
DOMAIN3=alawivpn.cloud
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN3}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN3=${sub1}.${DOMAIN3}
SUB_DOMAIN03=zoomcares.zoom.us.${sub1}.${DOMAIN3}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN3}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN3}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN3}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN3}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN3}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN03}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN3}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN03}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN03}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN03}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN3}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 4
elif [ $host -eq 4 ]
then
  clear
DOMAIN4=cakdayat.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN4}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN4=${sub1}.${DOMAIN4}
SUB_DOMAIN04=zoomcares.zoom.us.${sub1}.${DOMAIN4}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN4}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN4}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN4}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN4}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN4}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN04}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN4}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN04}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN04}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN04}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN4}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 5
elif [ $host -eq 5 ]
then
  clear
DOMAIN5=petapan.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN5}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN5=${sub1}.${DOMAIN5}
SUB_DOMAIN05=zoomcares.zoom.us.${sub1}.${DOMAIN5}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN5}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN5}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN5}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN5}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN5}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN05}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN5}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN05}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN05}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN05}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN5}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 6
elif [ $host -eq 6 ]
then
  clear
DOMAIN6=sayasantri.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN6}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN6=${sub1}.${DOMAIN6}
SUB_DOMAIN06=zoomcares.zoom.us.${sub1}.${DOMAIN6}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN6}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN6}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN6}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN6}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN6}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN06}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN6}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN06}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN06}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN06}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN6}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 7
elif [ $host -eq 7 ]
then
  clear
DOMAIN7=serverssh.biz.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN7}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN7=${sub1}.${DOMAIN7}
SUB_DOMAIN07=zoomcares.zoom.us.${sub1}.${DOMAIN7}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN7}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN7}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN7}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN7}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN7}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN07}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN7}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN07}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN07}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN07}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN7}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 8
elif [ $host -eq 8 ]
then
  clear
DOMAIN8=sshserver.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN8}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN8=${sub1}.${DOMAIN8}
SUB_DOMAIN08=zoomcares.zoom.us.${sub1}.${DOMAIN8}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN8}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN8}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN8}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN8}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN8}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN08}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN8}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN08}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN08}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN08}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN8}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 9
elif [ $host -eq 9 ]
then
  clear
DOMAIN9=udpserver.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN9}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN9=${sub1}.${DOMAIN9}
SUB_DOMAIN09=zoomcares.zoom.us.${sub1}.${DOMAIN9}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN9}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN9}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN9}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN9}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN9}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN09}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN9}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN09}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN09}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN09}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN9}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 10
elif [ $host -eq 10 ]
then
  clear
DOMAIN10=vmesserver.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN10}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN10=${sub1}.${DOMAIN10}
SUB_DOMAIN010=zoomcares.zoom.us.${sub1}.${DOMAIN10}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN10}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN10}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN10}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN10}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN10}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN010}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN10}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN010}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN010}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN010}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN10}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 11
elif [ $host -eq 11 ]
then
  clear
DOMAIN11=vpnbagus.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN11}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN11=${sub1}.${DOMAIN11}
SUB_DOMAIN011=zoomcares.zoom.us.${sub1}.${DOMAIN11}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN11}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN11}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN11}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN11}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN11}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN011}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN11}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN011}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN011}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN011}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN11}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 12
elif [ $host -eq 12 ]
then
  clear
DOMAIN12=vpnssh.biz.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN12}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN12=${sub1}.${DOMAIN12}
SUB_DOMAIN012=zoomcares.zoom.us.${sub1}.${DOMAIN12}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN12}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN12}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN12}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN12}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN12}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN012}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN12}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN012}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN012}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN012}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN12}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 13
elif [ $host -eq 13 ]
then
  clear
DOMAIN13=vpssantri.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN13}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN13=${sub1}.${DOMAIN13}
SUB_DOMAIN013=zoomcares.zoom.us.${sub1}.${DOMAIN13}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN13}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN13}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN13}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN13}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN13}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN013}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN13}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN013}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN013}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN013}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN13}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 14
elif [ $host -eq 14 ]
then
  clear
DOMAIN14=vpsvpn.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN14}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN14=${sub1}.${DOMAIN14}
SUB_DOMAIN014=zoomcares.zoom.us.${sub1}.${DOMAIN14}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN14}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN14}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN14}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN14}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN14}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN014}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN14}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN014}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN014}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN014}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN14}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 15
elif [ $host -eq 15 ]
then
  clear
DOMAIN15=wush.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN15}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN15=${sub1}.${DOMAIN15}
SUB_DOMAIN015=zoomcares.zoom.us.${sub1}.${DOMAIN15}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN15}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN15}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN15}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN15}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN15}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN015}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN15}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN015}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN015}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN015}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN15}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
#domain 16
elif [ $host -eq 16 ]
then
  clear
DOMAIN16=wussh.my.id
  echo -e ""
  echo -e "$biru┌──────────────────────────────────────────┐$NC"
  echo -e "$biru│      ${hijau} POINTING DOMAIN BY ALAWI VPN       $biru│$NC"
  echo -e "$biru└──────────────────────────────────────────┘$NC"
  echo -e "$biru------>$NC  ${hijau}xxx.${DOMAIN16}  $biru<------$NC"
  echo -e ""
  read -rp "masukkan subdomain kamu: " -e sub1
  read -rp "masukkan ip vps kamu   : " -e ip1

SUB_DOMAIN16=${sub1}.${DOMAIN16}
SUB_DOMAIN016=zoomcares.zoom.us.${sub1}.${DOMAIN16}
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP1=${ip1};
hijau="\e[92;1m"
echo -e ""
echo -e "Sedang pointing ${biru}${SUB_DOMAIN16}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN16}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN16}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN16}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN16}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
#zoomcares.zoom.us
echo -e "Sedang pointing ${biru}${SUB_DOMAIN016}$NC..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN16}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN016}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN016}'","content":"'${IP1}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN016}'","content":"'${IP1}'","ttl":120,"proxied":false}')
echo -e "${hijau}Sukses!$NC"
echo -e ""
sleep 3
clear
#pemberitahuan selesai
echo -e ""
echo -e "$biru┌──────────────────────────────────────────┐$NC"
echo -e "$biru│   ${hijau}POINTING DOMAIN KE CLOUDFLARE SELESAI  $biru│$NC"
echo -e "$biru└──────────────────────────────────────────┘$NC"
echo -e ""
echo -e "${hijau}Berhasil$NC Pointing ${biru}${SUB_DOMAIN16}$NC"
echo -e "         Untuk ip ${biru}${IP1}$NC"
echo -e ""
read -rp "$( echo -e "Tekan [ ${biru}enter$NC ] untuk kembali... ") "
echo ""
pointing
fi
