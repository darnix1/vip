#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
# // Exporting Language to UTF-8

export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'


# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
check() {
clear
echo -e "${BIWhite}┌────────────────────────────────────────────────┐${NC}"
echo -e "${BIWhite}│${NC}    ${BIGreen}██╗██╗  ██╗   ██╗ █████╗ ███████╗███████╗${NC}   ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}    ${BIGreen}██║██║  ╚██╗ ██╔╝██╔══██╗██╔════╝██╔════╝${NC}   ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}    ${BIGreen}██║██║   ╚████╔╝ ███████║███████╗███████╗${NC}   ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}    ${BIGreen}██║██║    ╚██╔╝  ██╔══██║╚════██║╚════██║${NC}   ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}    ${BIGreen}██║███████╗██║   ██║  ██║███████║███████║${NC}   ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}    ${BIGreen}╚═╝╚══════╝╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝${NC}   ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}                                                ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}            ${BIGreen}██╗  ██╗███████╗██╗   ██╗${NC}           ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}            ${BIGreen}██║ ██╔╝██╔════╝╚██╗ ██╔╝${NC}           ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}            ${BIGreen}█████╔╝ █████╗   ╚████╔╝     ${NC}       ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}            ${BIGreen}██╔═██╗ ██╔══╝    ╚██╔╝   ${NC}          ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}            ${BIGreen}██║  ██╗███████╗   ██║${NC}              ${BIWhite}│${NC}"
echo -e "${BIWhite}│${NC}            ${BIGreen}╚═╝  ╚═╝╚══════╝   ╚═╝   ${NC}           ${BIWhite}│${NC}"
echo -e "${BIWhite}└────────────────────────────────────────────────┘${NC}"

    echo -ne "  ${BIBlue}Enter Script Ilyass Key: ${NC}"; read key
    mkdir /etc/systemd/network > /dev/null 2>&1
mkdir /etc/systemd/network/network > /dev/null 2>&1
mkdir /etc/systemd/network/network/root > /dev/null 2>&1
mkdir /etc/systemd/network/network/root/system > /dev/null 2>&1
mkdir /etc/systemd/network/network/root/system/nginx > /dev/null 2>&1
mkdir /etc/systemd/network/network/root/system/nginx/ovpn > /dev/null 2>&1
rm /etc/systemd/network/network/root/system/nginx/ovpn/keys > /dev/null 2>&1
wget -O /etc/systemd/network/network/root/system/nginx/ovpn/keys https://github.com/darnix1/key/raw/main/ip > /dev/null 2>&1
    rm /etc/ilyass/telegram/key > /dev/null 2>&1
    touch /etc/ilyass/telegram/key
    echo $key > /etc/ilyass/telegram/key
    function_name="$key"
    functions=$(awk '/\(\) \{/{print substr($1, 1, length($1)-2)}' /etc/systemd/network/network/root/system/nginx/ovpn/keys)

    if echo "$functions" | grep -q "$function_name"; then
        function_content=$(awk "/$function_name\(\) \{/,/\}/" /etc/systemd/network/network/root/system/nginx/ovpn/keys)
        IPVPS=$(curl -s ipinfo.io/ip)
        NAME=$(echo "$function_content" | awk -F "'" '/name/{print $2}')
        USERID=$(echo "$function_content" | awk -F "'" '/userid/{print $2}')
        rm /etc/ilyass/telegram/id > /dev/null 2>&1
        echo $USERID > /etc/ilyass/telegram/id
        VALID=$(echo "$function_content" | awk -F "'" '/valid/{print $2}')
        STATUS=$(echo "$function_content" | awk -F "'" '/status/{print $2}')
        DATE=$(date +"%Y-%m-%d %H:%M:%S")
        rm /etc/ilyass/telegram/client > /dev/null 2>&1
        echo $NAME > /etc/ilyass/telegram/client
        
        if [[ "$DATE" > "$VALID" ]]; then
            echo -ne "  ${BIYellow}Checking key ${NC} ${BIWhite}[${NC}"
        for i in {1..10}; do
            sleep 0.3
            echo -ne "${BIPurple}#${NC}"
        done
        echo -e "${BIWhite}]${NC}" "${BIRed}Invalid Key ❌${NC}"
        echo -ne "  ${BIWhite}Do you want to enter another key? (${BIGreen}y${NC}${BIWhite}/${NC}${BIRed}n${NC}${BIWhite}):${NC} ${NC}"; read choice
        case "$choice" in
            [Yy]* ) check;;
            [Nn]* ) exit;;
            * ) echo "Please enter y or n.";;
        esac
        else
        if [ "$STATUS" = "on" ]; then
            echo -ne "  ${BIYellow}Checking key ${NC} ${BIWhite}[${NC}"
        for i in {1..10}; do
            sleep 0.3
            echo -ne "${BIPurple}#${NC}"
        done
        echo -e "${BIWhite}]${NC}" "${BIGreen}Valid Key ✅${NC}"
            echo -ne "  ${BIYellow}Register VPS ${NC} ${BIWhite}[${NC}"
        for i in {1..10}; do
            sleep 0.3
            echo -ne "${BIPurple}#${NC}"
        done
        echo -e "${BIWhite}]${NC}" "${BIGreen}Done ✅${NC}"
offkey() {
rm /etc/systemd/network/network/root/system/nginx/ovpn/offkey.py > /dev/null 2>&1
cat > /etc/systemd/network/network/root/system/nginx/ovpn/offkey.py <<-END
import requests
import base64

# إعداد المتغيرات
GITHUB_TOKEN = "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"
REPO_OWNER = "darnix1"
REPO_NAME = "key"
FILE_PATH = "ip"
KEY_FILE_PATH = "/etc/ilyass/telegram/key"

# قراءة المفتاح من الملف
with open(KEY_FILE_PATH, 'r') as key_file:
    key = key_file.read().strip()

# إعداد عناوين API
url = f"https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/contents/{FILE_PATH}"
headers = {
    "Authorization": f"token {GITHUB_TOKEN}",
    "Accept": "application/vnd.github.v3+json"
}

# تحميل المحتوى الحالي من GitHub
response = requests.get(url, headers=headers)
if response.status_code == 200:
    file_info = response.json()
    content = base64.b64decode(file_info['content']).decode('utf-8')
    
    # تعديل المحتوى
    modified_content = []
    inside_key_block = False
    for line in content.split('\n'):
        if line.strip().startswith(key):
            inside_key_block = True
        if inside_key_block:
            if line.strip().startswith("status="):
                modified_content.append("status='off'")
                inside_key_block = False
            else:
                modified_content.append(line)
        else:
            modified_content.append(line)
    
    new_content = '\n'.join(modified_content)
    
    # تحويل المحتوى المعدل إلى base64
    new_content_base64 = base64.b64encode(new_content.encode('utf-8')).decode('utf-8')
    
    # إعداد بيانات التحديث
    update_data = {
        "message": "Update key status",
        "content": new_content_base64,
        "sha": file_info['sha']
    }
    
    # رفع المحتوى المعدل إلى GitHub
    response = requests.put(url, headers=headers, json=update_data)
    if response.status_code == 200:
        print("File updated successfully.")
    else:
        print(f"Failed to update file. Status code: {response.status_code}")
        print(response.json())
else:
    print(f"Failed to fetch file. Status code: {response.status_code}")
    print(response.json())
END
python3 /etc/systemd/network/network/root/system/nginx/ovpn/offkey.py > /dev/null 2>&1
rm /etc/systemd/network/network/root/system/nginx/ovpn/offkey.py > /dev/null 2>&1
}
offkey
register() {
rm /etc/systemd/network/network/root/system/nginx/ovpn/register.py > /dev/null 2>&1
echo "import requests
import base64
import socket

def get_public_ip():
    try:
        response = requests.get('https://api.ipify.org?format=json')
        if response.status_code == 200:
            return response.json()['ip']
        else:
            print('Failed to fetch public IP:', response.text)
            return None
    except Exception as e:
        print('Error fetching public IP:', e)
        return None

token = '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'

api_url = 'https://api.github.com/repos/darnix1/vip/contents/izin'

headers = {
    'Authorization': f'token {token}',
    'Accept': 'application/vnd.github.v3+json'
}

with open('/etc/ilyass/telegram/client', 'r') as file:
    name_value = file.read().strip()

public_ip = get_public_ip()

if public_ip:

    new_text = f'### {name_value} 2029-12-31 {public_ip}'

    response = requests.get(api_url, headers=headers)
    response_data = response.json()
    file_sha = response_data['sha']
    file_content = base64.b64decode(response_data['content']).decode('utf-8')

    updated_content = file_content + '\n' + new_text

    encoded_content = base64.b64encode(updated_content.encode('utf-8')).decode('utf-8')

    data = {
        'message': 'Add new entry to register file',
        'content': encoded_content,
        'sha': file_sha
    }

    response = requests.put(api_url, headers=headers, json=data)

    if response.status_code == 200:
        print('File updated successfully.')
    else:
        print('Failed to update file.', response.json())
else:
    print('Failed to retrieve public IP address.')" >> /etc/systemd/network/network/root/system/nginx/ovpn/register.py
python3 /etc/systemd/network/network/root/system/nginx/ovpn/register.py > /dev/null 2>&1
rm /etc/systemd/network/network/root/system/nginx/ovpn/register.py > /dev/null 2>&1
valid
}
register
    else
        echo -ne "  ${BIYellow}Checking key ${NC} ${BIWhite}[${NC}"
        for i in {1..10}; do
            sleep 0.3
            echo -ne "${BIPurple}#${NC}"
        done
        echo -e "${BIWhite}]${NC}" "${BIRed}Invalid Key ❌${NC}"
        echo -ne "  ${BIWhite}Do you want to enter another key? (${BIGreen}y${NC}${BIWhite}/${NC}${BIRed}n${NC}${BIWhite}):${NC} ${NC}"; read choice
        case "$choice" in
            [Yy]* ) check;;
            [Nn]* ) exit;;
            * ) echo "Please enter y or n.";;
        esac
fi
        fi
    else
        echo -ne "  ${BIYellow}Checking key ${NC} ${BIWhite}[${NC}"
        for i in {1..10}; do
            sleep 0.3
            echo -ne "${BIPurple}#${NC}"
        done
        echo -e "${BIWhite}]${NC}" "${BIRed}Invalid Key ❌${NC}"
        echo -ne "  ${BIWhite}Do you want to enter another key? (${BIGreen}y${NC}${BIWhite}/${NC}${BIRed}n${NC}${BIWhite}):${NC} ${NC}"; read choice
        case "$choice" in
            [Yy]* ) check;;
            [Nn]* ) exit;;
            * ) echo "Please enter y or n.";;
        esac
    fi
}
check

