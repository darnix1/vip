#!/bin/bash

# Archivo para almacenar el contenido de msg y su timestamp
DIR="/etc/xdarnix" 
MSG_LOCAL_FILE="/etc/xdarnix/msg"
MSG_URL="https://gitea.com/xdarnix/msg/raw/branch/main/msg"
MSG_TIMESTAMP_FILE="/etc/xdarnix/msg_timestamp"

# Función para descargar y actualizar el archivo de funciones msg si ha cambiado
update_msg_file() {
  sudo curl -sSL "$MSG_URL" -o "$MSG_LOCAL_FILE"
  date -u > "$MSG_TIMESTAMP_FILE"
}

# Verificar si el archivo local existe y si ha cambiado
if [[ ! -f "$MSG_LOCAL_FILE" ]]; then
  update_msg_file
else
  # Usar If-Modified-Since para verificar si el archivo remoto ha cambiado
  if sudo curl -s -z "$MSG_LOCAL_FILE" -o "$MSG_LOCAL_FILE" "$MSG_URL"; then
    date -u > "$MSG_TIMESTAMP_FILE"
  fi
fi

# Incluir el archivo msg descargado
source "$MSG_LOCAL_FILE"

msg -bar
print_center " Hola mundo "

msg -bar
