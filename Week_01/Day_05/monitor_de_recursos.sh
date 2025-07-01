#!/bin/bash

# ============================
# Monitor de Recursos del Servidor
# Registra: Fecha/Hora, Memoria, Disco (/), CPU
# Guardado en: /var/log/monitor_recursos.log
# ============================

# Archivo de log
LOG="/var/log/monitor_recursos.log"

# Cabecera
echo -e "Hora\t\t\tMemoria\t\tDisco (root)\tCPU" | tee -a "$LOG"

# Duración (1 hora)
segundos="3600"
fin=$((SECONDS + segundos))

while [ $SECONDS -lt $fin ]; do
    TIEMPO=$(date "+%Y-%m-%d %H:%M:%S")

    MEMORIA=$(free -m | awk 'NR==2{printf "%.f%%\t\t", $3*100/$2 }')
    DISCO=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
    CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf("%.f", 100 - $1)}')

    echo -e "$TIEMPO\t$MEMORIA$DISCO$CPU" | tee -a "$LOG"

    sleep 3
done

