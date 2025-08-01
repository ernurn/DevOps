#!/bin/bash

proceso_largo() {
    sleep 5
    echo "✅ Proceso completado"
}

proceso_largo &       
pid=$!
echo "⏳ Ejecutando proceso... (PID $pid)"
wait $pid
echo "📌 Finalizado"
