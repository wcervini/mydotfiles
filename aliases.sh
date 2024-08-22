#!/bin/zsh
alias ll='ls -la --color'

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

alias cp="cp -i"     # confirm before overwriting something
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias rmf="rm -rf"
alias srmf='sudo rm -rf'
alias rsynd='rsync -av --delete'
alias rsyn='rsync -av'
alias omzt='omz theme'
alias mc="mc -u"
alias agi="sudo apt install -y"
alias esources="vim ~/.local/bin/"
alias so="source ~/.zshrc"
alias lsso="ls -la ~/.local/bin"
alias cdso="cd ~/.local/bin"
alias scst="sudo systemctl status"
alias scen="sudo systemctl enable"
alias scdis="sudo systemctl disable"
alias scstart="sudo systemctl start"
alias scstop="sudo systemctl stop"
alias servshow="sudo service --status-all"
alias apurg="sudo apt purge --auto-remove"
alias gini="git init"

function servstart(){ 
	local serv=$(systemd-escape "$1")
	sudo service "$serv" start
}

function servstop(){
	local serv=$(systemd-escape "$1")
	sudo service "$serv" stop
}

function servstat(){
	local serv=$(systemd-escape "$1")
	sudo service "$serv" status
}
