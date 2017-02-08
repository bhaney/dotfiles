
platform='unknown'
unamestr=$(uname)
if [[ $unamestr=="Linux" ]]; then
    platform="Linux"
elif [[ $unamestr=="Darwin" ]]; then
    platform="macOS"
fi
echo platform is $platform

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if [[ $platform=="macOS" ]]; then
    . $(brew --prefix root6)/libexec/thisroot.sh
    #activate bash completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

#variables to export
export SVNUSR=svn+ssh://bhaney@svn.cern.ch/reps/atlas-bhaney
export SVN_EDITOR="vim"
export CERN_USER=bhaney
export USER=bhaney
export PS1="\h:\W $ "


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
