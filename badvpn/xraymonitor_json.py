import subprocess
import json
import sys

XRAY = "/usr/local/bin/xray"
APISERVER = "127.0.0.1:10000"

def get_stats():
    result = subprocess.run([XRAY, "api", "statsquery", "--server", APISERVER], capture_output=True, text=True)
    return json.loads(result.stdout) if result.stdout else {}

if __name__ == "__main__":
    data = get_stats()
    if "--json" in sys.argv:
        stats = []
        for item in data.get('stat', []):
            if "name" in item and "value" in item:
                parts = item["name"].split(">>>")
                if len(parts) > 1 and parts[0] == "user":
                    stats.append({"user": parts[1], "value": item["value"]})
        print(json.dumps(stats))
