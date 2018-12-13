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
    if [ -d "/usr/local/anaconda3" ]; then
        . /usr/local/anaconda3/etc/profile.d/conda.sh
    fi
    #activate bash completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
    #load ROOT if available
    if [ -f /usr/local/bin/thisroot.sh ]; then
    . /usr/local/bin/thisroot.sh
    fi
fi

#lxplus specific paths
if [[ $(hostname -s) == lxplus* ]] || [[ $(hostname -s) == pcpenn* ]]; then
    PATH=$PATH:$HOME/bin
    export PATH
    export PATH="/afs/cern.ch/sw/XML/texlive/latest/bin/x86_64-linux:$PATH"
    eosfusebind
    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    alias setupATLAS='source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh' 
fi


#variables to export
export SVNUSR=svn+ssh://bhaney@svn.cern.ch/reps/atlas-bhaney
export SVN_EDITOR=vim
export EDITOR=vim
export CERN_USER=bhaney
export RUCIO_ACCOUNT=bhaney

#set up binaries in the npm directory
if [ -d "$HOME/npm/bin" ]; then
    export PATH=$HOME/npm/bin:$PATH
fi

#set up binaries in the .local directory
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
    export PYTHONPATH=$PYTHONPATH:$HOME/.local
fi

