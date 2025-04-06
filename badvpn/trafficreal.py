#!/usr/bin/python3
import subprocess
import json
import pandas as pd
from rich.console import Console
from rich.table import Table
from rich.style import Style
from rich.progress import Progress
import time

# Configuración
APISERVER = "127.0.0.1:10000"
XRAY = "/etc/xray/config.json"
REFRESH_SECONDS = 5  # Intervalo de actualización en segundos

console = Console()

def get_real_time_stats():
    """Obtiene estadísticas en tiempo real desde Xray"""
    result = subprocess.run(
        [XRAY, "api", "statsquery", "--server", APISERVER],
        capture_output=True, 
        text=True
    )
    
    try:
        data = json.loads(result.stdout)
        stats = []
        for item in data.get('stat', []):
            if "name" in item and "value" in item:
                parts = item["name"].split(">>>")
                if len(parts) > 3 and parts[0] == "user":
                    stats.append({
                        "user": parts[1],
                        "type": parts[3],  # uplink/downlink
                        "value": int(item["value"])
                    })
        return stats
    except json.JSONDecodeError:
        console.print("Error al leer datos de Xray", style="bold red")
        return []

def human_readable_size(size):
    """Convierte bytes a formato legible"""
    for unit in ['B', 'KB', 'MB', 'GB']:
        if size < 1024:
            return f"{size:.2f} {unit}"
        size /= 1024

def display_live_stats():
    """Muestra estadísticas en tiempo real con actualización automática"""
    with Progress(transient=True) as progress:
        task = progress.add_task("[cyan]🚀", total=None)
        
        while True:
            try:
                # Obtener y procesar datos
                stats = get_real_time_stats()
                df = pd.DataFrame(stats)
                
                if not df.empty:
                    # Filtrar y calcular totales
                    downlink = df[df['type'] == 'downlink'].groupby('user')['value'].sum()
                    uplink = df[df['type'] == 'uplink'].groupby('user')['value'].sum()
                    combined = pd.concat([downlink, uplink], axis=1)
                    combined.columns = ['Downlink', 'Uplink']
                    combined['Total'] = combined.sum(axis=1)
                    combined = combined.sort_values('Total', ascending=False)

                    # Limpiar consola y mostrar nueva tabla
                    console.clear()
                    table = Table(
                        title=f"[bold]Tráfico en Tiempo Real[/bold] (Actualizado cada {REFRESH_SECONDS}s)",
                        show_header=True,
                        header_style=Style(bold=True, color="blue")
                    )
                    
                    table.add_column("Usuario", style="cyan")
                    table.add_column("↓ Descarga", justify="right", style="green")
                    table.add_column("↑ Subida", justify="right", style="magenta")
                    table.add_column("Total", justify="right", style="bold yellow")

                    for user, row in combined.iterrows():
                        table.add_row(
                            user,
                            human_readable_size(row['Downlink']),
                            human_readable_size(row['Uplink']),
                            human_readable_size(row['Total'])
                        )

                    console.print(table)
                
                time.sleep(REFRESH_SECONDS)
                
            except KeyboardInterrupt:
                console.print("\n[bold yellow]Monitoreo detenido[/bold yellow]")
                break
            except Exception as e:
                console.print(f"[red]Error: {str(e)}[/red]")
                time.sleep(5)

if __name__ == "__main__":
    console.print("[bold green]Iniciando monitor en tiempo real...[/bold green]")
    console.print("Presiona Ctrl+C para salir\n")
    display_live_stats()
