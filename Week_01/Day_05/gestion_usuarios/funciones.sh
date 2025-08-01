crear_usuario() {
  local usuario="$1"

  if id "$usuario" &>/dev/null; then
    echo "El usuario $usuario ya existe."
  else
    if sudo useradd "$usuario"; then
      echo "Usuario $usuario creado el $(date)" >> usuarios.log
      echo "Usuario $usuario creado."
    else
      echo "Error al crear el usuario $usuario."
      return 1
    fi
  fi
}
