import subprocess
import json
import pandas as pd
from rich.console import Console
from rich.text import Text
from rich.panel import Panel
from rich.align import Align

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
        console.print("❌ [bold red]Failed to parse JSON[/bold red]")
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

    users = df_sorted['link'].unique()

    for user in users:
        user_data = df_sorted[df_sorted['link'] == user]
        if user_data.empty:
            continue

        up_value = user_data[user_data['type'] == 'uplink']['value'].sum()
        down_value = user_data[user_data['type'] == 'downlink']['value'].sum()
        total_value = up_value + down_value

        up_size = human_readable_size(up_value)
        down_size = human_readable_size(down_value)
        total_size = human_readable_size(total_value)

        # Ajustamos alineación y espaciamiento para centrar todo bien
        content = Text()
        content.append("─────────────────────────────\n", style="cyan")
        content.append("      [bold magenta]Tipo[/bold magenta]   │ [bold green]Tráfico[/bold green]  \n", style="bold")
        content.append("─────────────────────────────\n", style="cyan")
        content.append(f"[bold yellow]   Usuario: {user}   [/bold yellow]\n", style="bold")
        content.append(f"   [blue]downlink[/blue]  [white]{down_size}[/white]   [red]uplink[/red]  [white]{up_size}[/white]   \n")
        content.append(f"   [bold magenta]SUM->TOTAL:[/bold magenta]  {total_size}   \n", style="bold")
        content.append("─────────────────────────────\n", style="cyan")

        console.print(Align.center(Panel(content, border_style="blue", padding=(1, 8))))

if __name__ == "__main__":
    data = apidata(reset=False)
    print_sum(data, "user")
                    
