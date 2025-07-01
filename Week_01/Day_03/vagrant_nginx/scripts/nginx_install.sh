#!/bin/bash

set -e # Detiene el script si algún comando falla

echo "[INFO] Actualizando paquetes..."
apt update -y

echo "[INFO] Instalando Nginx..."
apt install -y nginx

echo "[INFO] Habilitando e iniciando Nginx..."
systemctl enable --now nginx

echo "[SUCCESS] Nginx fue instalado y está en ejecución."
