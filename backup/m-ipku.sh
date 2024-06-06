#!/bin/bash
# // PROJECT XDXL STORE
url_izin="https://raw.githubusercontent.com/awanklod/izin_jual/main/ip"
IP=$(curl -sS ipv4.icanhazip.com)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")

# Token awanklod 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
TOKEN="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"
today=`date -d "0 days" +"%Y-%m-%d"`
git clone https://github.com/darnix1/key.git /root/ipvps/ &> /dev/null
clear
echo -e ""
read -p "Input IP Address : " ip
CLIENT_EXISTS=$(grep -w $ip /root/ipvps/ip | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
echo "IP Already Exist !"
rm -rf /root/ipvps
exit 0
fi
echo -e ""
read -p " Input username : " name
echo -e ""
clear
read -p " Masukan waktu expired : " -e exp
exp2=`date -d "${exp} days" +"%Y-%m-%d"`
echo "### ${name} ${exp2} ${ip}" >> /root/ipvps/ip
cd /root/ipvps
git config --global user.email "fdanx@yahoo.com" &> /dev/null
git config --global user.name "darnix1" &> /dev/null
rm -rf .git &> /dev/null
git init &> /dev/null
git add . &> /dev/null
git commit -m register &> /dev/null
git branch -M main &> /dev/null
git remote add origin https://github.com/darnix1/key
git push -f https://${TOKEN}@github.com/darnix1/key.git &> /dev/null
rm -rf /root/ipvps
clear
