#!/bin/bash

JSON_DIR="/mnt/metrics"
ARCHIVE_DIR="/backups"

unix_timestamp=$(date +%s)

mv "$JSON_DIR"/status_*.json "$ARCHIVE_DIR"/

cd "$ARCHIVE_DIR"
tar -czf "status_${unix_timestamp}.tar.gz" status_*.json

rm -f status_*.json

echo "Archived JSON files at $ARCHIVE_DIR/status_${unix_timestamp}.tar.gz"
