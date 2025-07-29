

UNIX_TIMESTAMP=1753784700
FORMATTED_DATE=$(date -d @"$UNIX_TIMESTAMP" "+%Y-%m-%d %H:%M:%S")


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
} |  tee "$STATUS_HTML" > /dev/null



tee "$STATUS_JSON" > /dev/null <<EOF
{
  "hostname": $(echo "$HOSTNAME" | jq -Rs),
  "ip_address": $(echo "$IP_ADDRESS" | jq -Rs),
  "timestamp": $UNIX_TIMESTAMP,
  "cpu_usage": $(top -bn1 | grep '%Cpu' | head -1 | jq -Rs),
  "memory_usage": $(free -h | jq -Rs),
  "disk_usage": $(df -h | jq -Rs),
  "top_processes": $(ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 6 | column -t | jq -Rs)
}
EOF






