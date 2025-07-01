#!/bin/bash

SERVICIO="apache2"
ADMIN="admin@ejemplocorp.com"
LOG="/var/log/monitor_servicio.log"

# Obtener fecha y hora actual
FECHA=$(date "+%Y-%m-%d %H:%M:%S")

# Verificar si el servicio está inactivo
if ! systemctl is-active --quiet $SERVICIO; then
    systemctl start $SERVICIO

    MENSAJE="[$FECHA] El servicio $SERVICIO fue reiniciado."
    
    # Registrar en archivo log
    echo "$MENSAJE" >> $LOG

    # Enviar email de alerta
    echo "$MENSAJE" | mail -s "Reinicio de $SERVICIO" $ADMIN
fi
