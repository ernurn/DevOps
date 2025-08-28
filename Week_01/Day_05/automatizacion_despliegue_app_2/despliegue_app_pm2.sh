#!/bin/bash

set -e 

LOG="$(pwd)/despliegue_app.log"
declare -a SERVICIOS=(frontend merchandise products shopping-cart)

# Instalación de dependencias
instalar_dependencias() {
 echo "🔧 Instalando dependencias..." | tee -a "$LOG"
 sudo apt update >> "$LOG" 2>&1	
 
 if ! command -v node &>/dev/null; then
  echo "⚙️  Instalando Node.js y npm..." | tee -a "$LOG"
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - >>"$LOG" 2>&1

  sudo npm install -g pm2 >>"$LOG" 2>&1
 else
  echo "✅ PM2 ya está instalado" | tee -a "$LOG"
 fi
 
 if ! command -v git &>/dev/null; then
  echo "⚙️  Instalando GIT..." | tee -a "$LOG"
  sudo apt install -y git >> "$LOG" 2>&1
 else
  echo "✅ Git ya está instalado" | tee -a "$LOG"
 fi

 if ! command -v nginx &>/dev/null; then
  echo "⚙️  Instalando Nginx..." | tee -a "$LOG"
  sudo apt install -y nginx >> "$LOG" 2>&1
 else
  echo "✅ Nginx ya está instalado" | tee -a "$LOG"
 fi

}

# Clonar repositorio e instalar dependencias
clonar_y_preparar_entorno() {
  echo "🔍 Verificando existencia del repositorio" | tee -a "$LOG"
  if [ -d "devops-static-web" ]; then
   echo "📦 Moviendo repositorio antiguo..." | tee -a "$LOG"
   mv devops-static-web "devops-static-web-old-$(date +%Y-%m-%d_%H-%M-%S)" || {
      echo "❌ Error al mover repositorio antiguo" | tee -a "$LOG"
      exit 1
   }
   
   find . -maxdepth 1 -type d -name 'devops-static-web-old-*' -mtime +15 \
   -printf '✅ Eliminado respaldo antiguo: %p\n' -exec rm -rf {} \; \
| tee -a "$LOG"
  fi

  echo "📥 Clonando repositorio..." | tee -a "$LOG"
  git clone -b ecommerce-ms https://github.com/roxsross/devops-static-web.git >> "$LOG" 2>&1 || {
    echo "❌ Error al clonar el repositorio" | tee -a "$LOG"
    exit 1
  }

  cd devops-static-web || {
    echo "❌ No se pudo ingresar al directorio devops-static-web" | tee -a "$LOG"
    exit 1
  }

  for servicio in "${SERVICIOS[@]}"; do
   echo "🚀 Instalando servicio $servicio" | tee -a "$LOG"
   if [ -d "$servicio" ]; then
    pushd "$servicio" > /dev/null 2>&1 || {
        echo "❌ No se pudo acceder a $servicio" | tee -a "$LOG"
        exit 1
    }
    if [ -f "package.json" ]; then
     npm ci >> "$LOG" 2>&1 || {
      echo "❌ Error instalando dependencias en $servicio" | tee -a "$LOG"
      exit 1
     }
     echo "✅ Dependencias de $servicio instaladas" | tee -a "$LOG"
    else
     echo "⚠️ No se encontró package.json en $servicio" | tee -a "$LOG"
    fi
    
    popd > /dev/null 2>&1 || {
     echo "❌ Error al volver al directorio padre" | tee -a "$LOG"
     exit 1
    }
   else
    echo "⚠️ Directorio $servicio no existe, saltando..." | tee -a "$LOG"
   fi
  done
  
echo "✅ Entorno preparado correctamente" | tee -a "$LOG"
return 0
}

iniciar_servicios() {
  for servicio in "${SERVICIOS[@]}"; do
    echo "🚀 Iniciando servicio $servicio" | tee -a "$LOG"
    if pushd "$servicio" > /dev/null 2>&1; then
      if ! pm2 restart "$servicio" >> "$LOG" 2>&1; then
	echo "🆕 Servicio no existe, creando nuevo: $servicio" | tee -a "$LOG"  
        pm2 start server.js --name "$servicio" >> "$LOG" 2>&1 || {
        echo "❌ Error al iniciar $servicio" | tee -a "$LOG"
        exit 1
        }
      else
       echo "🔄 Servicio reiniciado: $servicio" | tee -a "$LOG"
      fi    
      popd > /dev/null 2>&1      
    else
      echo "❌ No se pudo acceder a $servicio" | tee -a "$LOG"
      exit 1
    fi
  done
}

configurar_nginx() {
  echo "📦 Configurando Nginx..." | tee -a "$LOG"
  sudo systemctl enable nginx >> "$LOG" 2>&1
  sudo systemctl start nginx >> "$LOG" 2>&1

  NGINX_CONF="/etc/nginx/sites-available/devops_static_web"
  sudo tee $NGINX_CONF > /dev/null <<EOL
server {
    listen 80;

    server_name localhost;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }

    location /merchandise {
        proxy_pass http://127.0.0.1:3001;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }

    location /products {
        proxy_pass http://127.0.0.1:3002;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }

    location /shopping-cart {
        proxy_pass http://127.0.0.1:3003;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOL

  sudo ln -sf $NGINX_CONF /etc/nginx/sites-enabled/ || {
   echo "❌ Error al habilitar configuración de Nginx" | tee -a "$LOG"
   exit 1
   }
  
  sudo rm -f /etc/nginx/sites-enabled/default

  sudo nginx -t && sudo systemctl reload nginx || {
   echo "❌ Error en la configuración de Nginx" | tee -a "$LOG"
   exit 1
   }
  echo "✅ Nginx configurado correctamente." | tee -a "$LOG"
}

configurar_pm2_autostart() {
  echo "⚙️  Configurando arranque automático con PM2..." | tee -a "$LOG"

  # Genera el comando de startup
  CMD=$(pm2 startup systemd -u $USER --hp $HOME | grep sudo)

  if [ -n "$CMD" ]; then
    echo "👉 Ejecutando: $CMD" | tee -a "$LOG"
    eval $CMD >> "$LOG" 2>&1
  else
    echo "⚠️ No se pudo generar el comando de startup" | tee -a "$LOG"
    exit 1
  fi

  # Guarda el estado actual de las apps
  pm2 save >> "$LOG" 2>&1 || {
    echo "❌ Error al guardar el estado de PM2" | tee -a "$LOG"
    exit 1
  }

  echo "✅ PM2 configurado para iniciar apps en cada reinicio." | tee -a "$LOG"
}

deshabilitar_pm2_autostart () {
 pm2 unstartup systemd
}


main(){  
   echo "🚀 Iniciando despliegue de ecommerce-ms" | tee -a "$LOG"
   instalar_dependencias
   clonar_y_preparar_entorno
   iniciar_servicios  
   configurar_nginx
   configurar_pm2_autostart
   #deshabilitar_pm2_autostart

  echo "🏁 Despliegue finalizado" | tee -a "$LOG"
  echo "📄 Revisá $LOG para detalles." | tee -a "$LOG"
  echo "🌐 Aplicación disponible en: http://$(hostname -I | awk '{print $1}')" | tee -a "$LOG"

}

main


