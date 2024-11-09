#!/bin/bash

SOURCE="/home/$(whoami)"
HOST="hexolexo@server"
REMOTE_PATH="/home/$(whoami)/backups"
TIMESTAMP=$(date +%Y:%m:%d_%H:%M)
BACKUP_DIR="$REMOTE_PATH/backup"
ARCHIVE_DIR="$REMOTE_PATH/archive"

rsync -avz --delete -P --exclude '*.mp3' --exclude '*.log' --exclude '*.tmp' --exclude '.local' --exclude '.var' --exclude '.mozilla' --exclude '*/.ollama' --exclude '*/.cache' --exclude '.cargo' --exclude '.floorp' --exclude 'scripts' --exclude 'target/' /home/$(whoami) hexolexo@server:/home/hexolexo/backups/backup

ssh $HOST "tar -czvf $ARCHIVE_DIR/backup_$TIMESTAMP.tar.gz $BACKUP_DIR"

ssh $HOST
