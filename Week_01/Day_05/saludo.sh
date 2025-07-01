#!/bin/bash
set -e				# si presenta error sale del script
echo "¿Cómo te llamás?"		# imprime mensaje en pantalla
read NOMBRE			# lee y almacena en variable 
echo "¡Hola $NOMBRE!"		# imprime en pantalla mensaje con el valor de la variable
