#!/bin/bash

echo "Iniciando configuración"

# 1. Crear estructura de carpetas
echo "Creando carpetas..."
mkdir -p data/plugins

# 2. Mover el Chunky.jar que ya tienes si no está en su sitio
if [ -f "Chunky.jar" ]; then
    echo "Moviendo Chunky.jar..."
    cp Chunky.jar data/plugins/
elif [ -f "data/plugins/Chunky.jar" ]; then
    echo "Chunky en la carpeta de plugins."
else
    echo "404 Chunky.jar."
    echo "Asegúrate de que el archivo se llame exactamente Chunky.jar"
fi

# 3. Corregir permisos para Docker (Vital para evitar el error de Zip)
echo "Ajustando permisos de la carpeta data..."
sudo chmod -R 777 data/

# 4. Levantar el contenedor
echo "Levantando el servidor de Minecraft..."
sudo docker compose up -d

echo "--------------------------------------------------------"
echo "El servidor está arrancando..."
echo "Monitorea logs con: sudo docker logs -f mc-purpur-server"
echo "--------------------------------------------------------"