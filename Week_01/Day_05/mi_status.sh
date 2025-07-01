#!/bin/bash

: << 'end' 
Consigna: Creá un script llamado mi_status.sh que muestre:

   - El nombre del usuario actual
   - El directorio en el que estás
   - La fecha y hora actual
end

# Variables
usuario=$(whoami) 			# usuario almacena el resultado del comando whoami (usuario actual)
ubicacion=$(pwd)			# ubicacion guarda la ruta del directorio actual (print working directory)
fecha_actual=$(date)			# fecha_actual guarda la fecha y hora actual (date)


# Salida
echo -e "Estado actual del usuario: $usuario \nubicación: $ubicacion \nfecha y hora: $fecha_actual"
