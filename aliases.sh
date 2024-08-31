#!/bin/zsh
#########################################
# ALIAS SECTION
#########################################


alias ll='ls -la --color'
alias ld='ls -ld *'
alias ls='ls --color=auto'
alias cp="cp -i"     # confirm before overwriting something
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias np='nano -w PKGBUILD'
#alias more=less
alias ran="python ~/proyectos/ranger-1.9.3/ranger.py"

# Grep Aliases
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# OMZ
alias omzt='omz theme set'
alias omztl="omz theme list"
alias omzplena="omz plugin enable"
alias omzpldis="omz plugin disable"
alias omzplin="omz plugin info"
alias omzplls="omz plugin disable"
alias omzpllo="omz plugin disable"

alias omzu="omz update"



# Directories Aliases
alias rmf="rm -rf"
alias srmf='sudo rm -rf'
alias mc="mc -u"

# Rsync Aliases
alias rsynd='rsync -av --delete'
alias rsyn='rsync -av'


# APT Aliases
alias agi="sudo apt install -y"
alias apurg="sudo apt purge --auto-remove"

#ZSH Shell Aliases
alias so="source ~/.zshrc"
alias esources="vim ~/.local/bin/aliases.sh"
alias bcat="batcat"
alias activate="source venv/bin/activate"
alias dactivate="source venv/bin/deactivate"
# .local/bin Folder Aliases
alias lsso="ls -la ~/.local/bin"
alias cdso="cd ~/.local/bin"

# Systemd Aliases
alias scst="sudo systemctl status"
alias scen="sudo systemctl enable"
alias scdis="sudo systemctl disable"
alias scstart="sudo systemctl start"
alias scstop="sudo systemctl stop"
alias servshow="sudo service --status-all"


alias gin="git init"

#Python Aliases
alias pea="pyenv activate"
alias ped="pyenv deactivate"
alias venv="python -m venv"
alias pyv="python --version"
alias pil="pip list"

# Kitty Plugins
alias icat="kitten icat"
alias icopy="kitten clipboard"
alias gcopy="kitten clipboard -g"

#
#########################################
# FUNCTIONS SECTION
#########################################


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

gzux() {
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

pyproject(){
	cp $HOME/.local/bin/pyproject.toml .
}

#########################################
# ENV SECTION
#########################################

export EXTERNAL="/external/"
export RESPALDO="$HOME/respaldo/"
export JAVA_HOME="/usr/java/"
export PROYECTS="$HOME/Proyects"
