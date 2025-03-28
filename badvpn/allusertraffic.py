import subprocess
import json
import pandas as pd
from rich.console import Console
from rich.table import Table
from rich.style import Style

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
    df_filtered = df[(df['direction'] == prefix) & (df['type'] == 'downlink')]  # Solo downlink
    df_sorted = df_filtered.sort_values(by='value', ascending=False)

    total_down = df_sorted['value'].sum()
    df_sorted['value'] = df_sorted['value'].apply(human_readable_size)

    # Estilos personalizados
    white_text = Style(color="white")

    # Crear tabla con `rich`
    table = Table(show_header=True, header_style=white_text, border_style="bold cyan")
    table.add_column("Usuario", justify="left", style=white_text, no_wrap=True)
    table.add_column("Tráfico", justify="right", style=white_text, no_wrap=True)

    for _, row in df_sorted.iterrows():
        entity = f"{row['direction']}:{row['link']}->downlink"
        value = row['value']
        table.add_row(entity, value)
        table.add_row("──────────────────────", "────────────")  # Línea separadora entre cada usuario

    # Línea final separadora y totales
    table.add_row("TOTAL", human_readable_size(total_down), style="bold yellow")

    console.print(table)

if __name__ == "__main__":
    data = apidata(reset=False)
    print_sum(data, "user")
    
