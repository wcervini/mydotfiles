#!/bin/zsh

# Función para calcular SHA1 de archivos en un directorio
calcular_sha1() {
    local dir="$1"
    find "$dir" -type f -exec sha1sum {} \; | sort >"${dir}/sha1sums.txt"
}

# Directorios a comparar
DIR1="$1"
DIR2="$2"

# Calcular SHA1 de ambos directorios
calcular_sha1 "$DIR1"
calcular_sha1 "$DIR2"

# Archivos de SHA1 generados
SHA1_FILE1="${DIR1}/sha1sums.txt"
SHA1_FILE2="${DIR2}/sha1sums.txt"

# Comparar SHA1 de ambos directorios
comm -23 <(awk '{print $1}' "$SHA1_FILE1") <(awk '{print $1}' "$SHA1_FILE2")
