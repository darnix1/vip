#!/usr/bin/python3
import json
import subprocess
import os
from pathlib import Path

# Configuración
XRAY = "/usr/local/bin/xray"
APISERVER = "127.0.0.1:10000"
STATS_DB = "/var/lib/xray/stats_accumulated.json"

def get_current_stats():
    try:
        result = subprocess.run(
            [XRAY, "api", "statsquery", "--server", APISERVER],
            capture_output=True,
            text=True,
            check=True
        )
        return json.loads(result.stdout).get('stat', [])
    except Exception as e:
        print(f"Error al obtener stats: {e}", file=sys.stderr)
        return []

def load_accumulated():
    if os.path.exists(STATS_DB):
        with open(STATS_DB) as f:
            return json.load(f)
    return {}

def save_accumulated(data):
    Path("/var/lib/xray").mkdir(exist_ok=True)
    with open(STATS_DB, 'w') as f:
        json.dump(data, f)

if __name__ == "__main__":
    # Obtener datos actuales de Xray
    current_stats = get_current_stats()
    
    # Cargar histórico acumulado
    accumulated = load_accumulated()

    # Procesar estadísticas
    for item in current_stats:
        if "name" in item and "value" in item:
            parts = item["name"].split(">>>")
            if len(parts) > 3 and parts[0] == "user":
                user = parts[1]
                traffic_type = parts[3]  # uplink/downlink
                key = f"{user}_{traffic_type}"
                accumulated[key] = accumulated.get(key, 0) + item["value"]

    # Guardar y generar reporte
    save_accumulated(accumulated)
    
    # Salida para check_xray_limits.sh (suma uplink + downlink)
    report = {}
    for key in accumulated:
        user = key.split("_")[0]
        report[user] = report.get(user, 0) + accumulated[key]
    
    print(json.dumps([{"user": k, "value": v} for k, v in report.items()]))
