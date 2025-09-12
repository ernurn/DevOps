# Deploy Fullstack Freelancer - Ansible Playbook

Este playbook de Ansible automatiza el despliegue de la plantilla "Freelancer" de Start Bootstrap en servidores web usando Nginx.

## Descripción

El playbook descarga e instala la plantilla Freelancer de Start Bootstrap, configura Nginx como servidor web y establece los permisos correctos para servir el contenido estático.

## Requisitos

- **Ansible**: Versión 2.9 o superior
- **Sistemas objetivo**: Ubuntu/Debian con acceso sudo
- **Conectividad**: Acceso SSH a los servidores objetivo
- **Python**: Instalado en los servidores objetivo

## Estructura del proyecto

```
.
├── playbook.yml            # Playbook principal
├── files/
│   └── nginx.conf          # Archivo de configuración de Nginx
└── inventory/              # Inventario de servidores
```

## Variables

| Variable | Valor por defecto | Descripción |
|----------|-------------------|-------------|
| `repo_url` | `https://github.com/startbootstrap/startbootstrap-freelancer/archive/gh-pages.tar.gz` | URL del archivo comprimido de la plantilla |
| `web_root` | `/var/www/freelancer` | Directorio donde se instalará el sitio web |

## Configuración

### 1. Inventario

Crea un archivo de inventario definiendo tus servidores:

```yml
webservers:
  hosts:
    nodo-XX:
      ansible_host: IP o Host
      ansible_user: User
      ansible_python_interpreter: /usr/bin/python3
```

### 2. Archivo de configuración Nginx

Crea el archivo `files/nginx.conf` con la configuración del virtual host:

```nginx
server {
    listen 80;
    server_name tu-dominio.com;
    root /var/www/freelancer;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

## Uso

### Ejecutar el playbook

```bash
# Ejecutar en todos los servidores del grupo webservers
ansible-playbook -i inventory/hosts playbook.yml

# Ejecutar en un servidor específico
ansible-playbook -i inventory/hosts playbook.yml --limit servidor1.ejemplo.com

# Ejecutar con usuario específico
ansible-playbook -i inventory/hosts playbook.yml -u usuario

# Modo dry-run para verificar cambios
ansible-playbook -i inventory/hosts playbook.yml --check
```

### Personalizar variables

```bash
# Cambiar directorio de instalación
ansible-playbook -i inventory/hosts playbook.yml -e "web_root=/var/www/mi-sitio"

# Usar URL diferente del template
ansible-playbook -i inventory/hosts playbook.yml -e "repo_url=https://mi-repo.com/template.tar.gz"
```

## Tareas que realiza el playbook

1. **Instalación de dependencias**: Instala Nginx, unzip y git
2. **Creación de directorios**: Crea el directorio web con permisos apropiados
3. **Descarga de template**: Descarga el archivo comprimido desde GitHub
4. **Extracción**: Descomprime el template directamente en el directorio web
5. **Limpieza**: Elimina archivos temporales
6. **Configuración Nginx**: Instala la configuración del virtual host
7. **Activación del sitio**: Habilita el sitio y deshabilita el sitio por defecto
8. **Permisos**: Establece permisos correctos para directorios (755) y archivos (644)

## Estructura de archivos resultante

Después de ejecutar el playbook:

```
/var/www/freelancer/
├── index.html
├── css/
├── js/
├── img/
└── ... (otros archivos del template)
```

## Verificación

Después del despliegue, puedes verificar:

```bash
# Estado del servicio Nginx
sudo systemctl status nginx

# Verificar configuración de Nginx
sudo nginx -t

# Verificar permisos
ls -la /var/www/freelancer/

# Probar conectividad
curl -I http://tu-servidor/
```

## Troubleshooting

### Errores comunes

- **Error de permisos**: Verificar que el usuario tenga privilegios sudo
- **Error de conexión**: Verificar conectividad SSH y configuración del inventario
- **Nginx no inicia**: Verificar sintaxis del archivo `files/nginx.conf`

### Logs útiles

```bash
# Logs de Ansible
ansible-playbook -vvv ...

# Logs de Nginx
sudo tail -f /var/log/nginx/error.log
sudo tail -f /var/log/nginx/access.log
```

## Personalización

Para personalizar el template o agregar funcionalidades:

1. Modifica las variables en el playbook
2. Ajusta la configuración de Nginx en `files/nginx.conf`
3. Agrega tareas adicionales según necesidades específicas

## Licencia

Este playbook está bajo la misma licencia que la plantilla Freelancer de Start Bootstrap (MIT License).
