
sudo dnf install jq -y

METRICS_DIR="/mnt/metrics"
if [ ! -d "$METRICS_DIR" ]; then
    sudo mkdir -p "$METRICS_DIR"
    sudo chown reporter:reporter "$METRICS_DIR"
    sudo chmod 750 "$METRICS_DIR"
fi


UNIX_TIMESTAMP=$(date +%s)
FORMATTED_DATE=$(date "+%Y-%m-%d %H:%M:%S")


STATUS_HTML="/var/www/html/status.html"
STATUS_JSON="/mnt/metrics/status_${UNIX_TIMESTAMP}.json"


HOSTNAME=$(hostname)
IP_ADDRESS=$(hostname -I | awk '{print $1}')
CPU_USAGE=$(top -bn1 | grep '%Cpu' | head -1)
MEMORY_USAGE=$(free -h)
DISK_USAGE=$(df -h)
TOP_PROCESSES=$(ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 6 | column -t)


{
    echo "<html><body>"
    echo "<h2>Hostname:</h2><p>${HOSTNAME}</p>"
    echo "<h2>IP Address:</h2><p>${IP_ADDRESS}</p>"
    echo "<h2>Current Time:</h2><p>${FORMATTED_DATE}</p>"
    echo "<h2>CPU Usage:</h2><pre>${CPU_USAGE}</pre>"
    echo "<h2>Memory Usage:</h2><pre>${MEMORY_USAGE}</pre>"
    echo "<h2>Disk Usage:</h2><pre>${DISK_USAGE}</pre>"
    echo "<h2>Top 5 Running Processes:</h2>"
    echo "<pre>${TOP_PROCESSES}</pre>"
    echo "</body></html>"
} | sudo tee "$STATUS_HTML" > /dev/null

sudo tee "$STATUS_JSON" > /dev/null <<EOF
{
  "hostname": "$(echo "$HOSTNAME" | jq -Rs | sed 's/^"//;s/"$//')",
  "ip_address": "$(echo "$IP_ADDRESS" | jq -Rs | sed 's/^"//;s/"$//')",
  "timestamp": "$UNIX_TIMESTAMP",
  "cpu_usage": $(top -bn1 | grep '%Cpu' | head -1 | jq -Rs),
  "memory_usage": $(free -h | jq -Rs),
  "disk_usage": $(df -h | jq -Rs),
  "top_processes": $(ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 6 | column -t | jq -Rs)
}
EOF

sudo chown reporter:reporter "$STATUS_HTML" "$STATUS_JSON"
sudo chmod 640 "$STATUS_HTML" "$STATUS_JSON"
sudo cp "$STATUS_HTML" "$METRICS_DIR/"
sudo chown reporter:reporter "$METRICS_DIR/status.html"




