#!/bin/bash

# Comentario
echo "Hola Mundo"

# Variables
NOMBRE="Ernesto"
echo "Hola $NOMBRE"

# Condicionales
if [ "$NOMBRE" == "Ernesto" ]; then
    echo "¡Sos vos!"
else
    echo "¿Y vos quién sos?"
fi

# Bucle
for i in {1..3}; do
    echo "Iteración $i"
done
