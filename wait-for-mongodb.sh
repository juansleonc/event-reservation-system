#!/bin/sh
# wait-for-mongodb.sh

set -e

host=$(echo "$1" | cut -d ':' -f 1)
port=$(echo "$1" | cut -d ':' -f 2)
shift
cmd="$@"

until nc -z "$host" "$port"; do
  >&2 echo "MongoDB no está disponible - reintentando"
  sleep 1
done

>&2 echo "MongoDB está disponible - iniciando servicio"
exec $cmd
