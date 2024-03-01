#!/bin/sh
# init-module.sh
# chmod +x init-module.sh

# Verifica si el archivo go.mod existe
if [ ! -f go.mod ]; then
  echo "go.mod no encontrado. Inicializando módulo..."
  go mod init basic
else
  echo "go.mod encontrado. Continuando..."
fi

# Ejecuta go mod tidy para asegurarse de que todas las dependencias estén actualizadas
go mod tidy
