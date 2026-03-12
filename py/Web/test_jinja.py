import os
import traceback
from jinja2 import Environment, FileSystemLoader

# Load template without importing app
env = Environment(loader=FileSystemLoader(r'd:\AI\AI-Traffic-Monitoring-System\py\Web\templates'))
try:
    template = env.get_template('Dashboard.html')
except Exception as e:
    with open('out_jinja.txt', 'w', encoding='utf-8') as f:
        f.write(f"Template load error: {e}")
    import sys; sys.exit(1)

stats = {
    'total_vehicles': 5,
    'running': 5,
    'stopped': 0,
    'offline': 0,
    'alerts': 0,
    'violations': 0,
    'quality': 100.0
}
vehicles = []

try:
    res = template.render(vehicles=vehicles, stats=stats, user={'username': 'admin'}, page=1, total_pages=1, now='2026-11-02 08:00')
    with open('out_jinja.txt', 'w', encoding='utf-8') as f:
        f.write("Render successful! Length: " + str(len(res)))
except Exception as e:
    with open('out_jinja.txt', 'w', encoding='utf-8') as f:
        traceback.print_exc(file=f)
