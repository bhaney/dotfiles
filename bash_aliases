#!/bin/bash

unamestr=$(uname -s)

if [[ "$unamestr" == 'Linux' ]]; then
    alias ll="ls -lth --color"
    alias lt="ls -ltrh --color"
    alias la="ls -lha --color"
    alias ls="ls --color"
    alias du="du -ah --max-depth=1"
    alias root="root -l"
    alias makey="make && make install"
elif [[ "$unamestr" == 'Darwin' ]]; then
    alias lt="ls -ltrhG"
    alias la="ls -lhaG"
    alias ls="ls -Gr"
    alias du="du -hc -d 1"
    alias makey="make && make inst"
fi

if [[ $(hostname -s) == lxplus* ]]; then
    alias makepdf="make cleanpdf && make"
fi

alias pwd="pwd -P"
alias grid="voms-proxy-init -voms atlas"
alias tier3="ssh tier3 -Y"
alias lxplus="ssh lxplus -Y"
alias gw="ssh atlasgw -Y"
alias prox="ssh tier3 -D8080"
alias octave="octave --no-gui"
alias sr="screen -r"
alias wttr="curl wttr.in"
alias untar="tar -xvzf"
