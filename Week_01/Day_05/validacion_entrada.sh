#!/bin/bash
if [[ $# -ne 1 ]]; then
    echo "Uso: $0 <archivo>"
    exit 1
elif [[ ! -f $1 ]]; then
    echo "Error: El archivo '$1' no existe."
    exit 2    
else
    cat "$1"
fi
