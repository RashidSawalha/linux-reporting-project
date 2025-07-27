TIMESTAMP=$(date +%s)
STATUS_HTML="/var/www/html/status_${TIMESTAMP}.html"
METRICS_DIR="/mnt/metrics"

if [ ! -d "$METRICS_DIR" ]; then
    sudo mkdir -p "$METRICS_DIR"
    sudo chown reporter:reporter "$METRICS_DIR"
    sudo chmod 755 "$METRICS_DIR"
fi

{
    echo "<html><body>"
    echo "<h2>Hostname:</h2><p>$(hostname)</p>"
    echo "<h2>IP Address:</h2><p>$(hostname -I | awk '{print $1}')</p>"
    echo "<h2>Current Time:</h2><p>$(date)</p>"
    echo "<h2>CPU Usage:</h2><pre>$(top -bn1 | grep '%Cpu')</pre>"
    echo "<h2>Memory Usage:</h2><pre>$(free -h)</pre>"
    echo "<h2>Disk Usage:</h2><pre>$(df -h)</pre>"
    echo "<h2>Top 5 Running Processes:</h2>"
    echo "<pre>$(ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 6)</pre>"
    echo "</body></html>"
} | sudo tee "$STATUS_HTML" > /dev/null

sudo chown reporter:reporter "$STATUS_HTML"
sudo cp "$STATUS_HTML" "$METRICS_DIR/"
sudo chown reporter:reporter "$METRICS_DIR/status_${TIMESTAMP}.html"


