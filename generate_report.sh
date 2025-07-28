

TIMESTAMP=$(date +%s)
STATUS_HTML="/var/www/html/status_${TIMESTAMP}.html"
STATUS_JSON="/mnt/metrics/status_${TIMESTAMP}.json"
METRICS_DIR="/mnt/metrics"


if [ ! -d "$METRICS_DIR" ]; then
    sudo mkdir -p "$METRICS_DIR"
    sudo chown reporter:reporter "$METRICS_DIR"
    sudo chmod 755 "$METRICS_DIR"
fi

HOSTNAME=$(hostname)
IP_ADDRESS=$(hostname -I | awk '{print $1}')
CURRENT_TIME=$(date)
CPU_USAGE=$(top -bn1 | grep '%Cpu' | sed 's/"/\\"/g')
MEMORY_USAGE=$(free -h | sed 's/"/\\"/g')
DISK_USAGE=$(df -h | sed 's/"/\\"/g')
TOP_PROCESSES=$(ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 6 | sed 's/"/\\"/g')

{
    echo "<html><body>"
    echo "<h2>Hostname:</h2><p>${HOSTNAME}</p>"
    echo "<h2>IP Address:</h2><p>${IP_ADDRESS}</p>"
    echo "<h2>Current Time:</h2><p>${CURRENT_TIME}</p>"
    echo "<h2>CPU Usage:</h2><pre>${CPU_USAGE}</pre>"
    echo "<h2>Memory Usage:</h2><pre>${MEMORY_USAGE}</pre>"
    echo "<h2>Disk Usage:</h2><pre>${DISK_USAGE}</pre>"
    echo "<h2>Top 5 Running Processes:</h2>"
    echo "<pre>${TOP_PROCESSES}</pre>"
    echo "</body></html>"
} | sudo tee "$STATUS_HTML" > /dev/null

sudo chown reporter:reporter "$STATUS_HTML"
sudo cp "$STATUS_HTML" "$METRICS_DIR/"
sudo chown reporter:reporter "$METRICS_DIR/status_${TIMESTAMP}.html"


sudo tee "$STATUS_JSON" > /dev/null <<EOF
{
  "hostname": "$HOSTNAME",
  "ip_address": "$IP_ADDRESS",
  "current_time": "$CURRENT_TIME",
  "cpu_usage": "$(echo "$CPU_USAGE" | tr '\n' '\\n')",
  "memory_usage": "$(echo "$MEMORY_USAGE" | tr '\n' '\\n')",
  "disk_usage": "$(echo "$DISK_USAGE" | tr '\n' '\\n')",
  "top_processes": "$(echo "$TOP_PROCESSES" | tr '\n' '\\n')"
}
EOF

sudo chown reporter:reporter "$STATUS_JSON"
sudo chmod 755 /mnt/metrics 
