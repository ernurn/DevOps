# Desafío Ansible Día 6 - Despliegue de Aplicación

[![Ansible Lint](https://img.shields.io/badge/ansible-lint-blue)](https://ansible-lint.readthedocs.io/)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

Este proyecto contiene un **playbook de Ansible** para desplegar una landing page fullstack con Nginx, crear un usuario `devops` con permisos sudo y configurar reglas de firewall (UFW) en servidores definidos en el inventario.

---

## 📁 Estructura del Proyecto

desafio_ansible_dia6/
├── Vagrantfile
├── playbook.yml
├── inventories/
│ └── webservers.yml
├── roles/
│ ├── nginx/
│ │ ├── defaults/main.yml
│ │ ├── tasks/main.yml
│ │ └── handlers/main.yml
│ ├── devops/
│ │ └── tasks/main.yml
│ └── firewall/
│ └── tasks/main.yml
└── README.md


---

## 🎯 Funcionalidad del Playbook

- **Nginx**
  - Instala Nginx en el servidor.
  - Crea directorio web y despliega template de landing page.
  - Configura permisos correctos y habilita el sitio.
- **Usuario DevOps**
  - Crea usuario `devops` con acceso sudo.
- **Firewall**
  - Instala UFW y permite puertos 22 (SSH), 80 (HTTP) y 443 (HTTPS).

---

## ⚡ Variables principales

- `web_root`: Directorio de la landing page (default: `/var/www/agency`).
- `repo_url`: URL del template (`.tar.gz`).

Definidas en: `roles/nginx/defaults/main.yml`.

---

## 🚀 Cómo ejecutar

1. Verificar inventario (`inventories/webservers.yml`):

```yaml
webservers:
  hosts:
    webserver-01:
      ansible_host: 172.27.107.130
      ansible_user: ubuntu
      ansible_python_interpreter: /usr/bin/python3

    Ejecutar el playbook:

ansible-playbook -i inventories/webservers.yml playbook.yml --ask-become-pass

✅ Validación post-despliegue

    Landing page:

curl http://<IP_DEL_SERVIDOR>

    Usuario devops:

ssh devops@<IP_DEL_SERVIDOR>
sudo whoami  # Debe devolver 'root'

    Firewall:

sudo ufw status

    Permisos web:

ls -l /var/www/agency

    Directorios: 0755

    Archivos: 0644

    Propietario: www-data

🛠️ Buenas prácticas

    Uso de roles para Nginx, usuario DevOps y firewall.

    Handlers para recargar Nginx solo cuando se hacen cambios.

    Uso de unarchive con --strip-components=1 para evitar subcarpetas innecesarias.

    Variables centralizadas en defaults/main.yml para fácil configuración.

📌 Licencia

MIT License

