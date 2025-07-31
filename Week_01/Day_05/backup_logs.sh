#!/bin/bash

set -e

BACKUP_DIR="$HOME/backups"
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%d-%m-%Y_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/log_$TIMESTAMP.tar.gz"

# Eliminación de backups antiguos (+ 7 días)
echo "Buscando backups mayores a 7 días para eliminar..."
find "$BACKUP_DIR" -name "log_*.tar.gz" -type f -mtime +7 -exec rm -v {} \;
echo "Limpieza de backups antiguos finalizada."

# Backup de /var/log
echo "Iniciando backup de /var/log a $BACKUP_FILE..."
sudo tar -czvf "$BACKUP_FILE" /var/log
echo "Backup finalizado exitosamente."
