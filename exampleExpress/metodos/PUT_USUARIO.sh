#!/usr/bin/bash

# METODO PUT USUARIO

# ====== VARIABLES =======
PORT=3000
id_usuario=$1
nombre=$2
email=$3
# ========================

if [[ -z $id_usuario || -z $nombre || -z $email ]]; then
    echo Parámetros incorrectos. Uso: comando \<id_usuario\> \<nuevo_nombre\> \<nuevo_email\>
else
    curl -X PUT http://localhost:$PORT/usuarios/$id_usuario \
     -H "Content-Type: application/json" \
     -d "{\"nombre\": \"$nombre\", \"email\": \"$email\"}"
fi