


JSON_DIR="/mnt/metrics"
ARCHIVE_DIR="/backups"

unix_timestamp=$(date +%s)

mv "$JSON_DIR"/status_*.json "$ARCHIVE_DIR"/
tar -czf "$ARCHIVE_DIR/status_${unix_timestamp}.tar.gz" -C "$ARCHIVE_DIR" status_*.json
rm -f "$ARCHIVE_DIR"/status_*.json

echo "Archived JSON files at $ARCHIVE_DIR/status_${unix_timestamp}.tar.gz"
