#!/bin/bash

/bin/echo "git pull updates from dotfiles.git"

# ssh-agent variables stored here
SSH_ENV="$HOME/.ssh/environment"

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null
else
    echo "No ssh-agent present. Create an agent, save its info in .ssh/enviornment, and make sure it is running with the right ssh key for github."
    exit 1
fi

cd ~/dotfiles/
git pull origin master
