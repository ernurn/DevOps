# Ecommerce Microservices - Despliegue Automatizado

Este proyecto implementa una aplicación de ecommerce basada en microservicios con despliegue automatizado usando Node.js, PM2 y Nginx como proxy reverso.

## 🏗️ Arquitectura

La aplicación está compuesta por los siguientes microservicios:

- **Frontend** (Puerto 3000): Interfaz de usuario principal
- **Merchandise** (Puerto 3001): Servicio de gestión de mercancías
- **Products** (Puerto 3002): Servicio de productos
- **Shopping Cart** (Puerto 3003): Servicio de carrito de compras

## 📋 Prerrequisitos

- Sistema operativo basado en Ubuntu/Debian
- Acceso sudo
- Conexión a internet para descargar dependencias

## 🚀 Instalación y Despliegue

### Instalación Automática

1. Descarga el script de despliegue:
```bash
wget [URL_DEL_SCRIPT] -O despliegue_app.sh
chmod +x despliegue_app.sh
```

2. Ejecuta el script:
```bash
./despliegue_app.sh
```

El script realizará automáticamente:
- Instalación de dependencias (Node.js, npm, PM2, Git, Nginx)
- Clonado del repositorio desde GitHub
- Instalación de dependencias de cada microservicio
- Configuración y arranque de servicios con PM2
- Configuración de Nginx como proxy reverso
- Configuración de arranque automático

### Instalación Manual

Si prefieres realizar la instalación paso a paso:

1. **Instalar dependencias del sistema:**
```bash
sudo apt update
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs git nginx
sudo npm install -g pm2
```

2. **Clonar el repositorio:**
```bash
git clone -b ecommerce-ms https://github.com/roxsross/devops-static-web.git
cd devops-static-web
```

3. **Instalar dependencias de cada servicio:**
```bash
# Para cada servicio (frontend, merchandise, products, shopping-cart)
cd [nombre-servicio]
npm ci
cd ..
```

4. **Iniciar servicios con PM2:**
```bash
cd frontend && pm2 start server.js --name frontend
cd ../merchandise && pm2 start server.js --name merchandise
cd ../products && pm2 start server.js --name products
cd ../shopping-cart && pm2 start server.js --name shopping-cart
```

## 🌐 Configuración de Nginx

El script configura automáticamente Nginx con las siguientes rutas:

- `/` → Frontend (localhost:3000)
- `/merchandise` → Servicio de mercancías (localhost:3001)
- `/products` → Servicio de productos (localhost:3002)
- `/shopping-cart` → Carrito de compras (localhost:3003)

## 📊 Gestión de Servicios

### Comandos PM2 Útiles

```bash
# Ver estado de todos los servicios
pm2 status

# Ver logs en tiempo real
pm2 logs

# Reiniciar un servicio específico
pm2 restart [nombre-servicio]

# Reiniciar todos los servicios
pm2 restart all

# Parar todos los servicios
pm2 stop all

# Eliminar un servicio
pm2 delete [nombre-servicio]
```

### Comandos Nginx

```bash
# Verificar configuración
sudo nginx -t

# Recargar configuración
sudo systemctl reload nginx

# Reiniciar Nginx
sudo systemctl restart nginx

# Ver estado
sudo systemctl status nginx
```

## 📁 Estructura del Proyecto

```
devops-static-web/
├── frontend/
│   ├── server.js
│   └── package.json
├── merchandise/
│   ├── server.js
│   └── package.json
├── products/
│   ├── server.js
│   └── package.json
└── shopping-cart/
    ├── server.js
    └── package.json
```

## 📝 Logs y Monitoreo

- **Log de despliegue:** `./despliegue_app.log`
- **Logs de PM2:** Accesibles mediante `pm2 logs`
- **Logs de Nginx:** `/var/log/nginx/access.log` y `/var/log/nginx/error.log`

## 🔧 Características del Script

- ✅ Verificación automática de dependencias instaladas
- ✅ Respaldo automático de versiones anteriores
- ✅ Limpieza de respaldos antiguos (>15 días)
- ✅ Configuración automática de arranque en boot
- ✅ Manejo de errores con salidas controladas
- ✅ Logging detallado de todas las operaciones

## 🐛 Solución de Problemas

### Verificar que los servicios estén corriendo:
```bash
pm2 status
```

### Verificar conectividad de puertos:
```bash
netstat -tlnp | grep -E '300[0-3]'
```

### Verificar configuración de Nginx:
```bash
sudo nginx -t
curl -I http://localhost
```

### Ver logs específicos:
```bash
pm2 logs [nombre-servicio]
tail -f despliegue_app.log
```

## 🌍 Acceso a la Aplicación

Una vez completado el despliegue, la aplicación estará disponible en:

```
http://[IP-DEL-SERVIDOR]
```

La IP del servidor se mostrará al finalizar el script de instalación.

## 🛠️ Configuración Avanzada

### Deshabilitar arranque automático de PM2:
Descomenta la línea en el script o ejecuta:
```bash
pm2 unstartup systemd
```

### Cambiar configuración de puertos:
Modifica los archivos `server.js` de cada servicio y actualiza la configuración de Nginx en `/etc/nginx/sites-available/devops_static_web`.

## 📞 Soporte

Para reportar problemas o solicitar funcionalidades, revisa los logs detallados generados durante el despliegue y verifica el estado de los servicios con los comandos proporcionados.

## 👨‍💻 Autor 
Ernesto Víctor Nurnberg
ITech Misiones
