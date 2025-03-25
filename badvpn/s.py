import subprocess
import json
import pandas as pd
from rich.console import Console
from rich.table import Table, box

APISERVER = "127.0.0.1:10000"
XRAY = "/usr/local/bin/xray"

console = Console()

def apidata(reset=False):
    args = ["--server", APISERVER]
    if reset:
        args.append("-reset=true")
    result = subprocess.run([XRAY, "api", "statsquery"] + args, capture_output=True, text=True)
    
    try:
        data = json.loads(result.stdout)
    except json.JSONDecodeError:
        console.print("Failed to parse JSON", style="bold red")
        return []

    parsed_data = []
    if 'stat' in data:
        for item in data['stat']:
            if "name" in item and "value" in item:
                name_parts = item["name"].split(">>>")
                if len(name_parts) > 3:
                    direction = name_parts[0]
                    link = name_parts[1]
                    entity = name_parts[2]
                    type_ = name_parts[3]
                    value = item["value"]
                    parsed_data.append({"direction": direction, "link": link, "entity": entity, "type": type_, "value": int(value)})
    
    return parsed_data

def human_readable_size(size, decimal_places=1):
    for unit in ['B', 'KB', 'MB', 'GB', 'TB']:
        if size < 1024:
            return f"{size:.{decimal_places}f} {unit}"
        size /= 1024

def print_sum(data, prefix):
    df = pd.DataFrame(data)
    df_filtered = df[df['direction'] == prefix]
    df_sorted = df_filtered.sort_values(by='value', ascending=False)

    # Agrupar por usuario
    users = df_sorted['link'].unique()

    for user in users:
        user_data = df_sorted[df_sorted['link'] == user]
        if user_data.empty:
            continue

        table = Table(title=f"Usuario: {user}", box=box.SQUARE, show_header=True, header_style="bold cyan")
        table.add_column("Type", justify="center", style="cyan", no_wrap=True)
        table.add_column("Traffic", justify="center", style="magenta", no_wrap=True)

        up_sum = user_data[user_data['type'] == 'uplink']['value'].sum()
        down_sum = user_data[user_data['type'] == 'downlink']['value'].sum()
        total_sum = up_sum + down_sum

        for _, row in user_data.iterrows():
            traffic_type = f"{row['type']}"
            value = human_readable_size(row['value'])
            table.add_row(traffic_type, value)

        table.add_row("", "")
        table.add_row("SUM->up:", human_readable_size(up_sum))
        table.add_row("SUM->down:", human_readable_size(down_sum))
        table.add_row("SUM->TOTAL:", human_readable_size(total_sum))

        console.print(table)
        console.print("-" * 40)  # Separador entre tablas

if __name__ == "__main__":
    data = apidata(reset=False)
    print_sum(data, "user")
