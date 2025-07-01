#!/bin/bash
set -e						# sale si presenta error
read -p "¿Tenés sed? (sí/no): " RESPUESTA	# imprime en pantalla y almacena en variable 

if [ "$RESPUESTA" == "si" ]; then		# condicional simple
  echo "Andá por un cafecito ☕"		# si cumple la condición
else
  echo "Seguimos con DevOps 🚀"			# no cumple la condición
fi
