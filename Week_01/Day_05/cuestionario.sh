#!/bin/bash

set -e

read -p "Ingresa tu nombre: " name
read -p "Ingresa tu edad: " age
read -p "Ingresa tu color favorito: " color

if [ "$age" -ge 18 ]; then
	echo -e "Felicidades "$name" sos mayor 💥"
else
	echo -e "Aún sos menor "$name" 🍼"
fi

case "${color,,}" in
    rojo)
        echo -e "🔥 El rojo es pasión pura, como vos."
        ;;
    azul)
        echo -e "🌊 El azul transmite calma... ¿sos de perfil tranquilo?"
        ;;
    verde)
        echo -e "🌱 Verde esperanza, ¡nunca pierdas esa energía!"
        ;;
    amarillo)
        echo -e "🌞 Amarillo brillante, como tu sonrisa."
        ;;
    negro)
        echo -e "🖤 Negro misterioso... ¡hay secretos en vos!"
        ;;
    *)
        echo -e "🎨 ¡$color es un color único, como vos!"
        ;;
esac
