#!/bin/bash

set -e

read -p "¿Qué tabla de multiplicar quiere visualizar?: " tabla

for i in {1..10}; do
	resultado=$(($tabla*$i))
	echo "$tabla * $i = $resultado"
done	
