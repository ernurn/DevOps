# 🧰 Proyecto Vagrant: Entorno de Pruebas con Ubuntu y Nginx

Este proyecto levanta automáticamente una máquina virtual Ubuntu 22.04 usando **Vagrant** y **VirtualBox**, con **Nginx instalado y configurado** mediante un script de provisionamiento.

---

## 📦 Requisitos

- [VirtualBox](https://www.virtualbox.org/) instalado
- [Vagrant](https://www.vagrantup.com/) instalado
- Git Bash / Terminal con soporte SSH (para conectarte a la VM)

---

## 🚀 ¿Qué hace este proyecto?

- Crea una VM con Ubuntu 22.04 (`ubuntu/jammy64`)
- Asigna 1 GB de RAM y 1 CPU
- Le da una IP privada fija: `192.168.56.10`
- Instala y habilita el servidor web **Nginx**
- Deja Nginx funcionando al arrancar la VM

---

## 📁 Estructura del proyecto
vagrant_nginx/
├── vagrantfile
├── README.md
└── scripts/
     └── nginx_install.sh


---

## ✅ Estado del entorno
🐧 Ubuntu 22.04 (jammy)

🌐 Nginx instalado

🔐 SSH disponible (vagrant ssh)

🌍 Accesible en http://192.168.56.10

---

