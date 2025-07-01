#!/bin/bash
set -e					# sale si presenta error 
ARCHIVO="config.txt"

if [ -f "$ARCHIVO" ]; then		# -f se refiere al archivo regulares -d a directorio -e se refiere a archivos o directorios (ambos)
  echo "El archivo $ARCHIVO existe"
else
  echo "No encontré el archivo $ARCHIVO"
fi
