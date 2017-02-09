#!/bin/bash

export PS1="\h:\W $ "

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if [[ $(uname -s) == 'Darwin' ]]; then
    . $(brew --prefix root6)/libexec/thisroot.sh
    #activate bash completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

if [[ $(hostname -s) == lxplus* ]]; then
    PATH=$PATH:$HOME/bin
    export PATH
    export PATH="/afs/cern.ch/sw/XML/texlive/latest/bin/x86_64-linux:$PATH"
fi


#variables to export
export SVNUSR=svn+ssh://bhaney@svn.cern.ch/reps/atlas-bhaney
export SVN_EDITOR="vim"
export CERN_USER=bhaney
export USER=bhaney
export RUCIO_ACCOUNT=bhaney


tbrowser () {
    # Check a file has been specified
    if (( $# == 0 )); then
        echo "No file(s) specified."
    else
    # For each file, check it exists
    for i; do
        if [ ! -f $i ]; then
            echo "Could not find file $i"
            return 1;
        fi
    done
    root -l $* $HOME/.macros/newBrowser.C
    fi
}

alias broot="tbrowser"
