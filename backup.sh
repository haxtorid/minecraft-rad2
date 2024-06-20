#!/bin/bash

# Backup directory
BACKUP_DIR="./backup"
mkdir -p "$BACKUP_DIR"

# Backup file name
BACKUP_FILE="$BACKUP_DIR/mincraft-rad-backup.tar"
BACKUP_FOLDER_ID="1jvUqA3R2vlDlSiboq8CxE6qc7KEHdwmb"

# Docker container name
CONTAINER_NAME="minecraft_rad"

# API details
API_URL="https://example.com/broadcast"
API_KEY="123"

echo "Starting backup..."
docker export $CONTAINER_NAME -o $BACKUP_FILE
UPLOAD_OUTPUT=$(gdrive files upload --parent="$BACKUP_FOLDER_ID" "$BACKUP_FILE")
echo "$UPLOAD_OUTPUT"

# Send POST request with upload result
curl -X POST "$API_URL" -H "x-api-key: $API_KEY" -H "Content-Type: application/json" -d "{\"message\": \"$UPLOAD_OUTPUT\"}"
echo "Backup completed."


echo "Start Script Remove oldest fiels"
# Get the list of files in the specified Google Drive folder
files=$(gdrive files list --parent="$BACKUP_FOLDER_ID")

# Parse the file IDs and created dates
file_ids=($(echo "$files" | awk 'NR>1 {print $1}'))
created_dates=($(echo "$files" | awk 'NR>1 {print $6 " " $7}'))

# Find the newest file (the one with the latest created date)
newest_file_index=0
newest_date=${created_dates[0]}

for i in "${!created_dates[@]}"; do
  if [[ "${created_dates[$i]}" > "$newest_date" ]]; then
    newest_date=${created_dates[$i]}
    newest_file_index=$i
  fi
done

# Get the ID of the newest file
newest_file_id=${file_ids[$newest_file_index]}

# Delete all files except the newest one
for i in "${!file_ids[@]}"; do
  if [[ "$i" != "$newest_file_index" ]]; then
    gdrive files delete "${file_ids[$i]}"
  fi
done

echo "Deleted all files except the newest one with ID: $newest_file_id"