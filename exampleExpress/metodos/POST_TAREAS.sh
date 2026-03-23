#!/usr/bin/bash

# METODO POST USUARIO

# ====== VARIABLES =======
PORT=3000
id_usuario=$1
titulo=$2
descripcion=$3
# ========================

if [[ -z $id_usuario || -z $titulo || -z $descripcion ]]; then
    echo Parámetros incorrectos. Uso: comando \<id_usuario\> \<titulo_tarea\> \<descripcion_tarea\>
else
    curl -X POST http://localhost:$PORT/usuarios/$id_usuario/tareas \
     -H "Content-Type: application/json" \
     -d "{\"titulo\": \"$titulo\", \"descripcion\": \"$descripcion\"}"
fi