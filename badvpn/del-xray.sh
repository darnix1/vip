#!/bin/bash

# Configuración
PYTHON_SCRIPT="/usr/local/bin/xraymonitor_json.py"  # Ajusta la ruta
XRAY_API_CMD="/usr/local/bin/xray api statsquery --server 127.0.0.1:10000"
STATS_DB="/var/lib/xray/stats_accumulated.json"

# --- Verificaciones previas ---
echo "=== Diagnóstico Xray Traffic Monitor ==="
echo ""

# 1. Verificar conexión con Xray
echo "🔍 Probando conexión con Xray API..."
XRAY_TEST=$($XRAY_API_CMD 2>&1)
if [ $? -ne 0 ]; then
    echo "❌ Error al conectar con Xray:"
    echo "$XRAY_TEST"
    exit 1
else
    echo "✅ Conexión exitosa"
    CURRENT_STATS=$(echo "$XRAY_TEST" | jq -r '.stat[] | "\(.name)=\(.value)"' 2>/dev/null)
    echo "📊 Datos crudos recibidos:"
    echo "$CURRENT_STATS" | head -n 3  # Muestra solo 3 líneas como ejemplo
    echo "... (total: $(echo "$CURRENT_STATS" | wc -l) registros)"
fi

# 2. Verificar archivo acumulado
echo ""
echo "📁 Verificando base de datos acumulada..."
if [ -f "$STATS_DB" ]; then
    DB_SIZE=$(stat -c %s "$STATS_DB")
    echo "✅ Archivo existe ($DB_SIZE bytes)"
    echo "📋 Contenido de ejemplo:"
    jq -r 'to_entries[] | "\(.key): \(.value)"' "$STATS_DB" | head -n 3
else
    echo "⚠️ Archivo no encontrado (se creará uno nuevo)"
fi

# --- Obtener datos ---
echo ""
echo "📡 Obteniendo estadísticas..."
PYTHON_OUTPUT=$($PYTHON_SCRIPT 2>&1)
if [ $? -ne 0 ]; then
    echo "❌ Error en el script Python:"
    echo "$PYTHON_OUTPUT"
    exit 1
fi

# --- Mostrar resultados ---
echo ""
echo "=== 📊 Resultados ==="
echo ""

# Formatear salida
if command -v jq >/dev/null; then
    echo "$PYTHON_OUTPUT" | jq -r '
        if length == 0 then
            "⚠️ No hay datos de usuarios"
        else
            .[] | "👤 \(.user) | 🚀 Tráfico total: \(.value / (1024*1024*1024) | round) GB"
        end
    '
else
    echo "$PYTHON_OUTPUT" | python3 -c '
import json, sys
try:
    data = json.load(sys.stdin)
    if not data:
        print("⚠️ No hay datos de usuarios")
    else:
        for item in data:
            gb = item["value"] / (1024 ** 3)
            print(f"👤 {item[\"user\"]} | 🚀 Tráfico total: {gb:.2f} GB")
except Exception as e:
    print(f"❌ Error procesando JSON: {e}")
'
fi

echo ""
echo "=== Fin del reporte ==="
