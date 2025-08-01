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

    if [ "$CPU" -gt 85 ]; then
        alerta_cpu=$((alerta_cpu + 1))
        if [ "$alerta_cpu" -ge 3 ]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - CPU sobrepasó 85% tres veces. Finalizando monitoreo." | tee -a "$LOG"
            break
        fi
    else
        alerta_cpu=0  # reinicia si baja el uso de CPU
    fi

    sleep 3
done

