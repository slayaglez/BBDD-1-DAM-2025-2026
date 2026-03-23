#!/usr/bin/bash

# METODO GET USUARIOS

# ====== VARIABLES =======
PORT=3000
id_usuario=$1
# ========================

if [[ "$id_usuario" =~ ^[0-9]+$ ]]; then 
    curl -X GET http://localhost:$PORT/usuarios/$id_usuario/tareas
else
    echo Parámetros incorrectos. Uso: comando \<id_usuario\>
fi