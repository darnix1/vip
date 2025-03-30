#!/usr/bin/python3
import subprocess
import json
import sys

XRAY = "/usr/local/bin/xray"
APISERVER = "127.0.0.1:10000"

def get_stats():
    try:
        result = subprocess.run(
            [XRAY, "api", "statsquery", "--server", APISERVER],
            capture_output=True,
            text=True,
            check=True
        )
        return json.loads(result.stdout)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return {"stat": []}

if __name__ == "__main__":
    data = get_stats()
    user_data = {}
    
    # Procesar todos los datos y sumar uplink + downlink
    for item in data.get('stat', []):
        if "name" in item and "value" in item:
            parts = item["name"].split(">>>")
            if len(parts) > 3 and parts[0] == "user":
                user = parts[1]
                traffic_type = parts[3]  # uplink o downlink
                if user not in user_data:
                    user_data[user] = 0
                user_data[user] += item["value"]
    
    # Convertir a formato JSON de salida
    output = [{"user": user, "value": total} for user, total in user_data.items()]
    print(json.dumps(output))
