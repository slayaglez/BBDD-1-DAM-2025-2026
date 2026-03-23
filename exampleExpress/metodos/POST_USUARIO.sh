#!/usr/bin/bash

# METODO POST USUARIO

# ====== VARIABLES =======
PORT=3000
nombre=$1
email=$2
# ========================

if [[ -z $nombre || -z $email ]]; then
    echo Parámetros incorrectos. Uso: comando \<nombre\> \<email\>
else
    curl -X POST http://localhost:$PORT/usuarios \
     -H "Content-Type: application/json" \
     -d "{\"nombre\": \"$nombre\", \"email\": \"$email\"}"
fi