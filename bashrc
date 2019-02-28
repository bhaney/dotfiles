#!/bin/bash

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\h:\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

#load the aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi


#activate conda if available
if [ -d "/usr/local/anaconda3" ]; then
    . /usr/local/anaconda3/etc/profile.d/conda.sh
fi

#load ROOT if available
if [ -f /usr/local/bin/thisroot.sh ]; then
. /usr/local/bin/thisroot.sh
fi

#for homebrew on macOS
if [[ $(uname -s) == 'Darwin' ]]; then
    #set up binaries from homebrew
    export PATH=/usr/local/bin:$PATH
    export PKG_CONFIG_PATH=/usr/local/include:$PKG_CONFIG_PATH
    export LD_LIBRARY_PATH=/usr/loca/lib:$LD_LIBRARY_PATH
fi

#variables to export
export SVNUSR=svn+ssh://bhaney@svn.cern.ch/reps/atlas-bhaney
export SVN_EDITOR=vim
export EDITOR=vim
export CERN_USER=bhaney
export RUCIO_ACCOUNT=bhaney

#set up binaries in the .local directory
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
    export PYTHONPATH=$PYTHONPATH:$HOME/.local
fi

#set up binaries in the npm directory
if [ -d "$HOME/npm/bin" ]; then
    export PATH=$HOME/npm/bin:$PATH
fi

#set up binaries in the rust directory
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH=$HOME/.cargo/bin:$PATH
fi

#set up binaries in the go directory
if [ -d "/usr/local/opt/go/libexec/bin" ]; then
    export PATH=$PATH:/usr/local/opt/go/libexec/bin
fi

