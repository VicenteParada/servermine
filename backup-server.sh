#!/bin/bash

CURRENT_DIR=$(pwd)
BACKUP_NAME="server-mine-$(date +%d-%m-%Y)"

USB_PATH=$(lsblk -no MOUNTPOINT | grep -E '^/(media|run/media)' | head -n 1)

echo "Buscando USB externo para respaldo..."

if [ -z "$USB_PATH" ]; then
    echo "Error: No se detectó ningún USB montado en /media o /run/media"
    exit 1
fi

DEST_DIR="$USB_PATH/backups_minecraft"
sudo mkdir -p "$DEST_DIR"

echo "USB detectado en: $USB_PATH"
echo "Iniciando respaldo de la carpeta 'data'..."


if [ "$(sudo docker ps -q -f name=mc-purpur-server)" ]; then
    echo "📡 Servidor detectado: Sincronizando mundo antes de comprimir..."
    sudo docker exec -i mc-purpur-server mc-send-command "save-off"
    sudo docker exec -i mc-purpur-server mc-send-command "save-all"
    sleep 2
fi

sudo tar -zcPf "$DEST_DIR/$BACKUP_NAME.tar.gz" "$CURRENT_DIR/data"

if [ "$(sudo docker ps -q -f name=mc-purpur-server)" ]; then
    sudo docker exec -i mc-purpur-server mc-send-command "save-on"
fi

sudo chown $USER:$USER "$DEST_DIR/$BACKUP_NAME.tar.gz"
echo "Backup guardado como: $BACKUP_NAME.tar.gz"