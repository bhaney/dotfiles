#!/bin/bash

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\h:\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

#load the aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi


#for homebrew on macOS
if [[ $(uname -s) == 'Darwin' ]]; then
    . $(brew --prefix root6)/libexec/thisroot.sh
    #activate bash completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

#lxplus specific paths
if [[ $(hostname -s) == lxplus* ]]; then
    PATH=$PATH:$HOME/bin
    export PATH
    export PATH="/afs/cern.ch/sw/XML/texlive/latest/bin/x86_64-linux:$PATH"
fi


#variables to export
export SVNUSR=svn+ssh://bhaney@svn.cern.ch/reps/atlas-bhaney
export SVN_EDITOR=vim
export EDITOR=vim
export CERN_USER=bhaney
export RUCIO_ACCOUNT=bhaney

#use broot to launch TBrowser from the command line
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
