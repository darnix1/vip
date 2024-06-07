#!/bin/bash

[[ -e /bin/xdarnix/msg ]] && source /bin/xdarnix/msg || source <(curl -sSL https://gitea.com/xdarnix/msg/raw/branch/main/msg)


print_center "Hola "
