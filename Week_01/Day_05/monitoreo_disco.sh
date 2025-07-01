#!/bin/bash
set -e
ADMIN="admin@ejemplocorp.com"									# correo electrónico donde se enviarán las alertas.
USO_RAIZ=$(df / | grep / | awk '{print $5}' | sed 's/%//g')					# queda con un número entero indicando el % de uso de /.
TAMANO_HOME=$(du -sh /home | awk '{print $1}' | sed 's/G//g')					# queda con el tamaño de /home en gigabytes, como un número decimal.

if [ "$USO_RAIZ" -ge 90 ]; then
    echo "¡Alerta: Partición / al ${USO_RAIZ}%!" | mail -s "Alerta Partición /" $ADMIN		#envía un correo electrónico a $ADMIN con asunto "Alerta Partición /" y un mensaje indicando el porcentaje.
fi

if (( $(echo "$TAMANO_HOME > 2" | bc -l) )); then
    echo "¡Alerta: /home ocupa ${TAMANO_HOME}GB!" | mail -s "Alerta Directorio /home" $ADMIN	# envía un  correo de alerta indicando cuánto ocupa /home.
fi
