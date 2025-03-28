import subprocess
import json
import pandas as pd
from rich.console import Console
from rich.table import Table, box
from rich.prompt import Prompt

APISERVER = "127.0.0.1:10000"
XRAY = "/usr/local/bin/xray"
console = Console()

def apidata(reset=False):
    args = ["--server", APISERVER]
    if reset:
        args.append("-reset=true")
    result = subprocess.run([XRAY, "api", "statsquery"] + args, capture_output=True, text=True)
    try:
        return json.loads(result.stdout)
    except json.JSONDecodeError:
        console.print("Error: No se pudo conectar a la API de Xray", style="bold red")
        return []

def get_users(data):
    users = set()
    for item in data.get('stat', []):
        if "name" in item:
            parts = item["name"].split(">>>")
            if len(parts) > 1 and parts[0] == "user":
                users.add(parts[1])
    return sorted(users)

def print_user_traffic(data, user):
    df = pd.DataFrame([
        {
            "direction": parts[0],
            "user": parts[1],
            "type": parts[3],
            "value": item["value"]
        }
        for item in data.get('stat', [])
        if "name" in item and "value" in item
        for parts in [item["name"].split(">>>")]
        if len(parts) > 3 and parts[0] == "user" and parts[1] == user
    ])

    if df.empty:
        console.print(f"[bold red]No hay datos para el usuario: {user}[/]")
        return

    uplink = df[df['type'] == 'uplink']['value'].sum()
    downlink = df[df['type'] == 'downlink']['value'].sum()
    total = uplink + downlink

    table = Table(title=f"Tráfico de {user}", box=box.ROUNDED)
    table.add_column("Tipo", style="cyan")
    table.add_column("Consumo", style="magenta", justify="right")
    table.add_row("Subida ↑", human_readable_size(uplink))
    table.add_row("Bajada ↓", human_readable_size(downlink))
    table.add_row("[bold]TOTAL[/]", f"[bold]{human_readable_size(total)}[/]")
    console.print(table)

def human_readable_size(size, decimal_places=2):
    for unit in ['B', 'KB', 'MB', 'GB', 'TB']:
        if size < 1024:
            return f"{size:.{decimal_places}f} {unit}"
        size /= 1024

def main():
    data = apidata()
    if not data:
        return

    users = get_users(data)
    if not users:
        console.print("No se encontraron usuarios activos.", style="bold yellow")
        return

    console.print("\n[bold]Usuarios disponibles:[/]", style="green")
    for i, user in enumerate(users, 1):
        console.print(f"{i}. {user}")

    # Corrección clave: Paréntesis correctamente balanceados
    selected = Prompt.ask(
        "\nSeleccione un usuario (número o nombre)",
        choices=[str(i) for i in range(1, len(users)+1)] + users,  # <- Corregido aquí
        default="1"
    )

    user = users[int(selected)-1] if selected.isdigit() else selected
    print_user_traffic(data, user)

if __name__ == "__main__":
    main()
