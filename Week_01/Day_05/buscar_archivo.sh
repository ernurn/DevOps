#!/bin/bash

read -p "Ingrese el nombre del archivo: " ARCHIVO
read -p "Ingrese la palabra a buscar dentro del archivo: " PALABRA

if [ -f "$ARCHIVO" ]; then
  echo "El archivo $ARCHIVO existe"
 
  # Busca la palabra  
  grep --color=auto -n "$PALABRA" "$ARCHIVO" || echo "No se encontró la palabra '$PALABRA'."
else
  echo "No encontré el archivo $ARCHIVO"
fi
