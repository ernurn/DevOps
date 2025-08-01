#!/bin/bash

archivos=("documento1.txt" "documento2.txt" "informe.pdf" "photo.jpg" "pic1.jpg" "pic2.jpg")
for archivo in "${archivos[@]}"; do
    echo "Procesando $archivo"
done
