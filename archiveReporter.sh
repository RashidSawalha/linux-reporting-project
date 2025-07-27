


echo "Archiving reports"

REPORT_DIR="/mnt/metrics"
ARCHIVE_DIR="/backups"
TIMESTAMP=$(date +%s)
ARCHIVE_NAME="status_${TIMESTAMP}.tar.gz"

mkdir -p "$ARCHIVE_DIR"

tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" -C "$REPORT_DIR" .

echo "Report archived at $ARCHIVE_DIR/$ARCHIVE_NAME"

