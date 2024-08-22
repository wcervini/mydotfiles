#!/bin/bash

# Función para comprimir un directorio
gzx() {
    # Verificar si se proporcionó un argumento
    if [ -z "$1" ]; then
        echo "Uso: comprimir_directorio <directorio>"
        return 1
    fi

    # Nombre del directorio a comprimir
    local directorio="$1"

    # Verificar si el directorio existe
    if [ ! -d "$directorio" ]; then
        echo "Error: El directorio '$directorio' no existe."
        return 1
    fi

    # Nombre del archivo comprimido
    local archivo_comprimido="${directorio}.tar.gz"

    # Comprimir el directorio
    tar -cf - "$directorio" | pigz >"$archivo_comprimido"

    # Verificar si la compresión fue exitosa
    if [ $? -eq 0 ]; then
        echo "El directorio '$directorio' ha sido comprimido exitosamente en '$archivo_comprimido'."
    else
        echo "Error: Falló la compresión del directorio '$directorio'."
        return 1
    fi
}

