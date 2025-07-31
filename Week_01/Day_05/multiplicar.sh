#!/bin/bash

set -e

read -p "Ingrese un número: " num1
read -p "Ingrese otro número: " num2

echo "El resultado es: $((num1*num2))"
