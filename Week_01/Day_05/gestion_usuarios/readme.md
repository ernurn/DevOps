# Scripts de Gestión de Usuarios

Este repositorio contiene scripts de bash para la gestión automatizada de usuarios en sistemas Linux.

## Archivos

- `crear_usuario.sh` - Script principal para crear usuarios
- `funciones.sh` - Biblioteca de funciones auxiliares

## Descripción

### funciones.sh

Contiene la función `crear_usuario()` que:
- Verifica si el usuario ya existe en el sistema
- Crea un nuevo usuario usando `useradd`
- Registra la creación en un archivo de log (`usuarios.log`)
- Maneja errores durante el proceso de creación

### crear_usuario.sh

Script principal que:
- Valida que se proporcione exactamente un parámetro (nombre de usuario)
- Importa las funciones desde `funciones.sh`
- Ejecuta la función de creación de usuario

## Uso

### Prerrequisitos

- Sistema Linux/Unix
- Permisos de sudo para crear usuarios
- Bash shell

### Instalación

1. Clona o descarga los archivos:
```bash
wget script1.sh -O crear_usuario.sh
wget script2.sh -O funciones.sh
```

2. Otorga permisos de ejecución:
```bash
chmod +x crear_usuario.sh
chmod +x funciones.sh
```

### Ejecución

```bash
./crear_usuario.sh <nombre_usuario>
```

#### Ejemplos

```bash
# Crear usuario llamado "juan"
./crear_usuario.sh juan

# Crear usuario llamado "maria"
./crear_usuario.sh maria
```

## Funcionalidades

### ✅ Validación de entrada
- Verifica que se proporcione exactamente un parámetro
- Muestra mensaje de uso si los parámetros son incorrectos

### ✅ Verificación de existencia
- Comprueba si el usuario ya existe antes de intentar crearlo
- Evita errores por duplicación

### ✅ Logging automático
- Registra cada usuario creado en `usuarios.log`
- Incluye fecha y hora de creación

### ✅ Manejo de errores
- Informa sobre errores durante la creación
- Códigos de salida apropiados para scripts

## Salidas esperadas

### Usuario creado exitosamente:
```
Usuario juan creado.
```

### Usuario ya existe:
```
El usuario juan ya existe.
```

### Error en la creación:
```
Error al crear el usuario juan.
```

### Uso incorrecto:
```
Uso: ./crear_usuario.sh <nombre_usuario>
```

## Archivo de log

El script genera un archivo `usuarios.log` en el directorio actual con el formato:
```
Usuario juan creado el Fri Aug 29 10:30:45 ART 2025
Usuario maria creado el Fri Aug 29 10:31:12 ART 2025
```

## Permisos requeridos

El script requiere permisos de sudo para ejecutar el comando `useradd`. Asegúrate de que el usuario que ejecuta el script tenga los permisos necesarios.

## Estructura del proyecto

```
.
├── crear_usuario.sh    # Script principal
├── funciones.sh        # Biblioteca de funciones
├── usuarios.log        # Log de usuarios creados (generado automáticamente)
└── README.md          # Este archivo
```

## Notas técnicas

- Los scripts están escritos en Bash
- Compatible con la mayoría de distribuciones Linux
- Utiliza el comando estándar `useradd` del sistema
- El logging utiliza el comando `date` para timestamps


## Contribuciones

Las contribuciones son bienvenidas. Por favor, asegúrate de probar los cambios en un entorno seguro antes de enviar pull requests.

## 👨‍💻 Autor
Ernesto Víctor Nurnberg
ITech Misiones
