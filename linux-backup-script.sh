#!/bin/bash

source ~/.azbackup/.env

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup-$TIMESTAMP.tar.gz"
SOURCE_DIR="/var/www/html"
TMP_DIR="/tmp"
BACKUP_PATH="$TMP_DIR/$BACKUP_NAME"

echo "Crating backupfile..."
tar -czf "$BACKUP_PATH" "$SOURCE_DIR"

echo "Copying backup to Azure..."
azcopy copy "$BACKUP_PATH" "https://$STORAGE_ACCOUNT_NAME.blob.core.windows.net/$CONTAINER_NAME/$BACKUP_NAME$STORAGE_SAS_TOKEN" --overwrite=true

echo "Deleting local backup file"
rm "$BACKUP_PATH"
