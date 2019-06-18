#!/usr/bin/env sh


# Se establece el identificador de projecto para
# evitar que Docker Compose asigne uno.
# Esto es importante para poder reusarlo en otros directorios
# Si usamos el mismo identificador en otro proyecto,
# será realmente el mismo.
docker-compose -p lab_jenkins up -d 

docker-compose -p lab_jenkins logs -f