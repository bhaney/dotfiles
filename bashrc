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

#variables to export
export SVNUSR=svn+ssh://bhaney@svn.cern.ch/reps/atlas-bhaney
export SVN_EDITOR=vim
export EDITOR=vim
export CERN_USER=bhaney
export RUCIO_ACCOUNT=bhaney

# set up PATH directories, order matters, most import first in dir!

#set up binaries in the .local directory
if [ -d "$HOME/.local/bin" ]; then
    export PATH=$HOME/.local/bin:$PATH
    export PYTHONPATH=$PYTHONPATH:$HOME/.local
fi

#for Go binaries on macOS
if [ -d "$HOME/go/bin" ]; then
    export PATH=$HOME/go/bin:$PATH
fi

#for homebrew on macOS
if [[ $(uname -s) == 'Darwin' ]]; then
    #set up binaries from homebrew
    export PATH=/usr/local/bin:$PATH
    export PYTHONPATH=/usr/local/lib:$PYTHONPATH
fi

#set up binaries in the conda directory
if [ -d "$HOME/opt/miniconda3" ]; then
    export PATH=$HOME/opt/miniconda3/bin:$HOME/opt/miniconda3/condabin:$PATH
fi

# paths for viam work computer
comp=$(hostname)
if [[ $comp = "NambuGoldstone.local" ]]; then
    export GOPRIVATE=github.com/viamrobotics/*,go.viam.com/*
    export GOOGLE_APPLICATION_CREDENTIALS=/Users/bijanh/.ssh/engineering-tools-310515-eae804383660.json
    export LD_LIBRARY_PATH=/Users/bijanh/opt/miniconda3/lib:/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH
    export PKG_CONFIG_PATH=/System/Library/Frameworks/Python.framework/Versions/2.7/lib/pkgconfig:$PKG_CONFIG_PATH
    export PKG_CONFIG_PATH=/opt/homebrew/opt/opencv@3/lib/pkgconfig:$PKG_CONFIG_PATH
    export PKG_CONFIG_PATH=/opt/homebrew/Cellar/arpack/3.8.0/lib/pkgconfig:$PKG_CONFIG_PATH
    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig:$PKG_CONFIG_PATH
fi
if [[ $comp = "visionquest.local" -o $comp = "erhnx.local" ]]; then
    export GOPRIVATE=github.com/viamrobotics/*,go.viam.com/*
    export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH
    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig:$PKG_CONFIG_PATH
fi

if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
