# Utilizar la imagen base oficial de Go para la compilación y ejecución
FROM golang:1.22-alpine

# Instala git y netcat. Git es requerido para fetching las dependencias.
# Netcat es necesario para el script de espera.
RUN apk update && apk add --no-cache git netcat-openbsd

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos de la fuente al contenedor
COPY . .

# Ejecutar el script que inicializa el módulo de Go si es necesario
RUN chmod +x ./init-module.sh && ./init-module.sh

# Instala Air para hot reloading
RUN go install github.com/cosmtrek/air@latest

# Copia el archivo de configuración de Air al directorio de trabajo (si tienes uno)
COPY .air.toml ./.air.toml

# Copia el script de espera al contenedor y da permisos de ejecución
COPY wait-for-mongodb.sh /usr/wait-for-mongodb.sh
RUN chmod +x /usr/wait-for-mongodb.sh

# Expone el puerto 8080
EXPOSE 8080

# Usa Air para ejecutar tu aplicación para desarrollo con hot reloading
CMD ["/usr/wait-for-mongodb.sh", "mongodb:27017", "air"]
