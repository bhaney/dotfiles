test -f ~/.bashrc && source ~/.bashrc

if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add
fi
# >>> conda initialize >>>
### !! Contents within this block are managed by 'conda init' !!
comp=$(hostname)
if [[ $comp = "NambuGoldstone.local" ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
    __conda_setup="$('/Users/bijanh/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/bijanh/opt/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/bijanh/opt/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/bijanh/opt/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi
# <<< conda initialize <<<

