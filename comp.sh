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

# Función para verificar la integridad de archivos gzip
gzchk() {
    if [ -z "$1" ]; then
        echo "Uso: gzchk <archivo.gz>"
        return 1
    fi

    if gzip -t "$1" >/dev/null 2>&1; then
        echo "$1 es un archivo gzip válido."
    else
        echo "$1 no es un archivo gzip válido o está corrupto."
    fi
}

ugz() {
    pigz -dc "$1" | tar -xf -
}

prj(){
	cd "$HOME/Proyects/$1"
}

# Define una función para copiar y permitir .envrc
crerc() {
  local envrc_source="$HOME/.local/bin/.envrc.sh"
  local envrc_dest=".envrc"

  # Verifica si el archivo fuente existe
  if [[ ! -f "$envrc_source" ]]; then
    echo "El archivo de configuración fuente ($envrc_source) no existe."
    return 1
  fi

  # Copia el archivo de configuración
  cp "$envrc_source" "$envrc_dest"
  
  # Verifica si la copia fue exitosa
  if [[ $? -ne 0 ]]; then
    echo "No se pudo copiar el archivo .envrc."
    return 1
  fi

  echo ".envrc creado y configurado."

  # Permitir el archivo con direnv
  if command -v direnv > /dev/null; then
    direnv allow
    echo ".envrc permitido con direnv."
  else
    echo "direnv no está instalado. No se pudo permitir el archivo .envrc."
  fi
}

