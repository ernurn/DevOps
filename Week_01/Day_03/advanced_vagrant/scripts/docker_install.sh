#!/bin/bash

echo "[INFO] Actualizando paquetes..."
apt update

echo "[INFO] Instalando Docker..."
apt install -y docker.io

echo "[INFO] Habilitando e iniciando Docker..."
systemctl enable --now docker
