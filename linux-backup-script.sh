#!/bin/bash

source ~/.azbackup/.env

TIMESTAMP=$(date+"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME ="backup-$TIMESTAMP.tar.gz"
SOURCE_DIR="/var/www/html"
TMP_DIR="/tmp"
BACKUP_PATH="$TMP_DIR/$BACKUP_NAME"

tar -czf "$BACKUP_PATH" "$SOURCE_DIR"

azcopy "$BACKUP_PATH" \ "https://$STORAGE_ACCOUNT_NAME.blob.core.windows.net/$CONTAINER_NAME/$BACKUP_NAME?$STORAGE_ACCOUNT_KEY" \ --overwrite=true

rm "$BACKUP_PATH"

