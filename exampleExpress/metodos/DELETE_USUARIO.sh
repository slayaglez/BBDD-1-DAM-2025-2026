#!/usr/bin/bash

# METODO DELETE USUARIO

# ====== VARIABLES =======
PORT=3000
id_usuario=$1

# ========================

if [[ -z $id_usuario ]]; then
    echo Parámetros incorrectos. Uso: comando \<id_usuario\>
else
    
    echo ⚠️  ¿Estás seguro de que deseas eliminar el siguiente usuario?⚠️

    curl -X GET http://localhost:$PORT/usuarios/$id_usuario
    
    echo
    echo "(s/n)"
    read -r eleccion

    if [[ "$eleccion" =~ ^(s|S)$ ]]; then   
        curl -X DELETE http://localhost:3000/usuarios/$id_usuario
    else 
        echo "Cancelando operación..."
    fi
fi