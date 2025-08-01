#!/bin/bash
json='{"nombre": "Pedro", "edad": 28, "ciudad": "Eldorado"}'
nombre=$(echo "$json" | jq -r '.nombre')
edad=$(echo "$json" | jq -r '.edad')
ciudad=$(echo "$json" | jq -r '.ciudad')
echo "Nombre: $nombre, Edad: $edad, Ciudad: $ciudad"
