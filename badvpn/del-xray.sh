#!/bin/bash

# Ruta al script Python
PYTHON_SCRIPT="/usr/local/bin/xraymonitor_json.py"

# Ejecutar el script Python y capturar la salida JSON
PYTHON_OUTPUT=$($PYTHON_SCRIPT)

# Verificar si la ejecución fue exitosa
if [ $? -ne 0 ]; then
    echo "Error al ejecutar el script Python"
    exit 1
fi

# Procesar la salida JSON
echo "=== Estadísticas de tráfico acumulado de Xray ==="
echo ""

# Usar jq para parsear el JSON si está disponible
if command -v jq &> /dev/null; then
    echo "$PYTHON_OUTPUT" | jq -r '.[] | "Usuario: \(.user) | Tráfico total: \(.value / (1024 * 1024 * 1024) | round) GB"'
else
    # Alternativa sin jq (solo para formato simple)
    echo "$PYTHON_OUTPUT" | python3 -c '
import json, sys
data = json.load(sys.stdin)
for item in data:
    gb = item["value"] / (1024 ** 3)
    print(f"Usuario: {item[\"user\"]} | Tráfico total: {gb:.2f} GB")
'
fi

echo ""
echo "=== Fin del reporte ==="
