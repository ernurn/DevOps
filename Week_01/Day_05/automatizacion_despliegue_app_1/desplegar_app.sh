#!/bin/bash

set -e

LOG="$(pwd)/despliegue_app.log"

# Instalación de dependencias
instalar_dependencias() {
  echo "🔧 Instalando dependencias..." | tee -a "$LOG"
  sudo apt update >> "$LOG" 2>&1
  sudo apt install -y python3 python3-pip python3-venv nginx git curl >> "$LOG" 2>&1

  echo "✔️  Habilitando nginx..." | tee -a "$LOG"
  sudo systemctl enable nginx >> "$LOG" 2>&1

  echo "🚀 Iniciando nginx..." | tee -a "$LOG"
  sudo systemctl start nginx >> "$LOG" 2>&1
}

# Clonar el repositorio y preparar el entorno Python
clonar_y_preparar_entorno() {
  echo "🔍 Verificando existencia del repositorio"
  if [ -d "devops-static-web" ]; then
   echo "📦 Moviendo repositorio antiguo..." | tee -a "$LOG"
   mv devops-static-web devops-static-web-old-$(date +%d-%m-%Y)
   find . -maxdepth 1 -type d -name 'devops-static-web-old-*' -mtime +15 \
  -printf '✅ Eliminado respaldo antiguo: %p\n' -exec rm -rf {} \; \
| tee -a "$LOG"
  fi 

  echo "📥 Clonando repositorio..." | tee -a "$LOG"
  git clone -b booklibrary https://github.com/roxsross/devops-static-web.git >> "$LOG" 2>&1 || {
    echo "❌ Error al clonar el repositorio" | tee -a "$LOG"
    exit 1
  }

  cd devops-static-web || {
    echo "❌ No se pudo ingresar al directorio devops-static-web" | tee -a "$LOG"
    exit 1
  }

  echo "🐍 Creando entorno virtual..." | tee -a "$LOG"
  python3 -m venv venv >> "$LOG" 2>&1
  source venv/bin/activate

  echo "📦 Instalando dependencias Python..." | tee -a "$LOG"
  pip install -r requirements.txt >> "$LOG" 2>&1
  pip install gunicorn >> "$LOG" 2>&1

  echo "✅  Entorno preparado correctamente" | tee -a "$LOG"
}

configurar_gunicorn() {	
  echo "🔥 Iniciando Gunicorn..." | tee -a "$LOG"
  nohup venv/bin/gunicorn -w 4 -b 0.0.0.0:8000 library_site:app >> "$LOG" 2>&1 &
  sleep 3
  echo "✅  Gunicorn corriendo en http://localhost:8000" | tee -a "$LOG"
}

configurar_nginx() {
  echo "🛠️ Configurando Nginx como proxy reverso..." | tee -a "$LOG"

  # Eliminar configuración por defecto para evitar conflictos
  sudo rm -f /etc/nginx/sites-enabled/default

  # Crear archivo de configuración para la app
  sudo tee /etc/nginx/sites-available/booklibrary > /dev/null <<EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_redirect off;
    }

    location /static/ {
        alias $(pwd)/static/;
        expires 30d;
    }

    access_log /var/log/nginx/booklibrary_access.log;
    error_log /var/log/nginx/booklibrary_error.log;
}
EOF

  # Enlazar configuración y recargar Nginx si es válida
  sudo ln -sf /etc/nginx/sites-available/booklibrary /etc/nginx/sites-enabled/
  if sudo nginx -t >> "$LOG" 2>&1; then
    sudo systemctl reload nginx
    echo "✅  Nginx configurado y recargado correctamente" | tee -a "$LOG"
  else
    echo "❌ Error en la configuración de Nginx. Revisá el log." | tee -a "$LOG"
  fi
}

verificar_servicios() {
  echo "🔍 Verificando servicios..." | tee -a "$LOG"

  # Verificar Nginx (servicio)
  if systemctl is-active --quiet nginx; then
    echo "✅  Nginx está activo" | tee -a "$LOG"
  else
    echo "❌ Nginx no está activo" | tee -a "$LOG"
  fi

  # Verificar Gunicorn (proceso)
  if pgrep -f "gunicorn.*library_site" > /dev/null; then
    echo "✅  Gunicorn está corriendo" | tee -a "$LOG"
  else
    echo "❌ Gunicorn no está corriendo" | tee -a "$LOG"
  fi

  # Verificar puerto 8000 (Gunicorn)
  if ss -tlnp 2>/dev/null | grep -q ":8000"; then
    echo "✅  Puerto 8000 en uso (Gunicorn)" | tee -a "$LOG"
  else
    echo "❌ Puerto 8000 no está en uso" | tee -a "$LOG"
  fi

  # Probar conexión directa a Gunicorn
  if curl -s http://127.0.0.1:8000 > /dev/null; then
    echo "✅  Gunicorn responde correctamente" | tee -a "$LOG"
  else
    echo "❌ Gunicorn no responde" | tee -a "$LOG"
  fi

  # NUEVO: Probar respuesta a través de Nginx (proxy reverso)
  if curl -s http://localhost > /dev/null; then
    echo "✅  Nginx proxy responde correctamente" | tee -a "$LOG"
  else
    echo "❌ Nginx proxy no está respondiendo" | tee -a "$LOG"
  fi
}

main() {
  echo "🚀 Iniciando despliegue de Book Library " | tee -a "$LOG"
  instalar_dependencias
  clonar_y_preparar_entorno
  configurar_gunicorn
  configurar_nginx
  verificar_servicios
  
  echo "🏁 Despliegue finalizado" | tee -a "$LOG"
  echo "📄 Revisá $LOG para detalles." | tee -a "$LOG"
  echo "🌐 La aplicación debería estar disponible en: http://$(hostname -I | awk '{print $1}')" | tee -a "$LOG"
}

main
