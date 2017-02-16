#!/bin/bash

export PS1="\h:\W $ "

#load the aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

#set up the ssh-agent already present, or start a new ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    (umask 066; ssh-agent > "${SSH_ENV}")
    . "${SSH_ENV}" > /dev/null
}

# Source SSH settings, if applicable
if [[ $(hostname -s) == lxplus* ]]; then
    echo 'start ssh agent manually if needed on lxplus.';
elif [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
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
