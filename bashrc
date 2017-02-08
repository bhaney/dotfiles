
#activate bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi
#export paths for PyROOT
#export ROOTSYS=/usr/local/root
#export PATH=$ROOTSYS/bin:$PATH
#export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH
#export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH
. $(brew --prefix root6)/libexec/thisroot.sh

export PS1="\h:\w $ "

alias lt="ls -ltrhG"
alias la="ls -lhaG"
alias ls="ls -Gr"
alias du="du -hc -d 1"
alias makey="make && make inst"
alias vi="/usr/local/bin/vim"
alias tier3="ssh tier3 -Y"
alias lxplus="ssh lxplus -Y"
alias gw="ssh atlasgw -Y"
alias prox="ssh tier3 -D8080"
alias octave="octave --no-gui"

export SVN_EDITOR=vim

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
