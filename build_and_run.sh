#!/bin/bash

IMAGE_NAME="ubuntu-xfce-vscode"
CONTAINER_NAME="dev-container"

echo "🔨 Construint la imatge Docker: $IMAGE_NAME..."
docker build -t $IMAGE_NAME .

echo "🧹 Eliminant contenidor anterior (si existeix)..."
docker rm -f $CONTAINER_NAME 2>/dev/null

echo "🚀 Arrencant el contenidor: $CONTAINER_NAME..."
docker run -d \
    -p 5901:5901 \
    -p 2222:22 \
    --name $CONTAINER_NAME \
    $IMAGE_NAME

echo "✅ Contenidor en execució!"
echo "📡 VNC -> localhost:5901 (usuari: developer, contrasenya: vncpassword)"
echo "🔐 SSH -> ssh developer@localhost -p 2222 (contrasenya: vncpassword)"

