#!/bin/bash

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\h:\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

#load the aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

#load ROOT if available
if [ -f /usr/local/bin/thisroot.sh ]; then
. /usr/local/bin/thisroot.sh
fi

#for homebrew on macOS
if [[ $(uname -s) == 'Darwin' ]]; then
    #set up binaries from homebrew
    export PATH=/usr/local/bin:$PATH
fi

#variables to export
export SVNUSR=svn+ssh://bhaney@svn.cern.ch/reps/atlas-bhaney
export SVN_EDITOR=vim
export EDITOR=vim
export CERN_USER=bhaney
export RUCIO_ACCOUNT=bhaney

export PYTHONPATH=$PYTHONPATH:/usr/local/lib
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

# paths for viam work computer
comp=$(hostname)
if [[ $comp = "NambuGoldstone.local" ]]; then
    export GOPRIVATE=github.com/viamrobotics/*,go.viam.com/*
    export LD_LIBRARY_PATH=/Users/bijanh/opt/miniconda3/lib:/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH
    export PKG_CONFIG_PATH=/System/Library/Frameworks/Python.framework/Versions/2.7/lib/pkgconfig:$PKG_CONFIG_PATH
    export PKG_CONFIG_PATH=/opt/homebrew/opt/opencv@3/lib/pkgconfig:$PKG_CONFIG_PATH
    export PKG_CONFIG_PATH=/opt/homebrew/Cellar/arpack/3.8.0/lib/pkgconfig:$PKG_CONFIG_PATH
    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig:$PKG_CONFIG_PATH
fi

#set up cuda binaries
#if [ -d "/usr/local/cuda-10.1/bin" ]; then
#    export PATH=/usr/local/cuda-10.1/bin:$PATH
#    export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64:$LD_LIBRARY_PATH
#fi

