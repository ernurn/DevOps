
# 📚 Despliegue Automatizado de BookLibrary con Nginx + Gunicorn

Este proyecto contiene un script Bash (`desplegar_app.sh`) que automatiza el despliegue de la aplicación **BookLibrary**.  
El proceso incluye instalación de dependencias, configuración de Gunicorn, Nginx como proxy reverso y verificación de servicios.

---

## 🚀 Funcionalidades del script

- **Instalación automática** de dependencias necesarias: `python3`, `pip`, `venv`, `nginx`, `git`, `curl`.
- **Clonado del repositorio** de la app (`devops-static-web` branch `booklibrary`).
- **Gestión de backups**: versiones previas del repo se renombran y se eliminan automáticamente si superan los **15 días**.
- **Creación de entorno virtual** con dependencias de Python y **Gunicorn**.
- **Configuración automática de Nginx** como proxy reverso hacia Gunicorn en el puerto 8000.
- **Verificación de servicios**:
  - Nginx activo
  - Gunicorn corriendo
  - Puerto 8000 abierto
  - Conexión directa a Gunicorn
  - Respuesta vía Nginx proxy
- **Logging detallado** en el archivo `despliegue_app.log`.

---

## 📂 Estructura esperada

```
.
├── desplegar_app.sh         # Script de despliegue
├── despliegue_app.log       # Log generado automáticamente
└── devops-static-web/       # Repo clonado de la app
```

Los backups se guardan como:
```
devops-static-web-old-<DD-MM-YYYY>
```

---

## 🔧 Requisitos previos

- Sistema operativo basado en **Debian/Ubuntu** con `systemd`.
- Permisos de **sudo** para instalar paquetes y configurar Nginx.
- Acceso a internet para clonar el repositorio y descargar dependencias.

---

## ▶️ Ejecución

1. Dar permisos de ejecución al script:
   ```bash
   chmod +x desplegar_app.sh
   ```

2. Ejecutar el despliegue:
   ```bash
   ./desplegar_app.sh
   ```

3. Seguir el log en tiempo real (opcional):
   ```bash
   tail -f despliegue_app.log
   ```

---

## 🌐 Acceso a la aplicación

Una vez finalizado el despliegue, la aplicación estará disponible en:

```
http://<IP_DEL_SERVIDOR>
```

El script muestra automáticamente la IP al finalizar.

---

## 🧹 Limpieza automática de repositorios antiguos

Cada vez que se ejecuta el script:
- Si ya existe `devops-static-web/`, se renombra a `devops-static-web-old-<fecha>`.
- Los directorios `devops-static-web-old-*` con más de **15 días** se eliminan automáticamente.

---

## 🛡️ Manejo de errores

- El script utiliza `set -e` → se detiene ante errores críticos.
- Los mensajes se registran en `despliegue_app.log`.
- Validaciones para:
  - Fallo al clonar el repo.
  - Problemas en la configuración de Nginx.
  - Gunicorn no iniciando correctamente.

---

## ⏱️ Ejecución automática (cron)

Para ejecutar el despliegue **una vez por semana**, agregar al cron:

```bash
crontab -e
```

Ejemplo: correr todos los domingos a las 02:00 AM:
```
0 2 * * 0 /ruta/completa/desplegar_app.sh >> /ruta/completa/despliegue_app.log 2>&1
```

---

## 📄 Licencia

Uso libre para fines educativos y de automatización.
