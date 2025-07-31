#!/bin/bash
set -e

ADMIN="admin@ejemplocorp.com"                         # Correo electrónico para alertas
LOGFILE="/var/log/monitor_disco.log"                  # Log local

# Verificar si el comando mail está disponible
if ! command -v mail >/dev/null 2>&1; then
    echo "Error: El comando 'mail' no está instalado." >&2
    exit 1
fi

# Verifica uso de la partición raíz
USO_RAIZ=$(df / | grep / | awk '{print $5}' | sed 's/%//g')

if [ "$USO_RAIZ" -ge 90 ]; then
    MENSAJE="¡Alerta: Partición / al ${USO_RAIZ}%!"
    echo "$MENSAJE" | mail -s "Alerta Partición /" $ADMIN
    echo "$(date '+%d-%m-%Y %H:%M:%S') - $MENSAJE" >> "$LOGFILE"
fi

# Verifica tamaño del /home y unidad
TAMANO_HOME_OUTPUT=$(du -sh /home | awk '{print $1}')
TAMANO_HOME_VALOR=$(echo $TAMANO_HOME_OUTPUT | sed 's/[A-Za-z]//g')
TAMANO_HOME_UNIDAD=$(echo $TAMANO_HOME_OUTPUT | sed 's/[0-9.]//g')

if [ "$TAMANO_HOME_UNIDAD" = "G" ] && (( $(echo "$TAMANO_HOME_VALOR > 2" | bc -l) )); then
    MENSAJE="¡Alerta: /home ocupa ${TAMANO_HOME_VALOR}GB!"
    echo "$MENSAJE" | mail -s "Alerta Directorio /home" $ADMIN
    echo "$(date '+%d-%m-%Y %H:%M:%S') - $MENSAJE" >> "$LOGFILE"
fi
