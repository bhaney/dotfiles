# Dotfiles

This is a simple dotfile manager that is used to keep dotfiles synched between multiple macOS and Linux machines. Most alises are specific to my names and accounts, so be sure to change `bashrc` and `bash_aliases` to suit your purposes if you decide to use them as a template.


Based heavily on [Michael J. Smalley's dotfiles](https://github.com/michaeljsmalley/dotfiles)

## First time set up

```bash
$ git clone git@github.com:bhaney/dotfiles.git
$ cd ~/dotfiles
$ source makesymlinks.sh # edit the 'files' variable to only use the dotfiles you want
```

This will move any dotfiles you already have to `dotfiles_old/` and make symlinks from `dotfiles/` to your home directory.

## Setting up ssh keys

To use ssh and ssh-agent with git, follow [these instructions](https://help.github.com/articles/connecting-to-github-with-ssh/) by GitHub.

## Cron job for syncing

On each computer where I use these dotfiles, I have a cron job to automatically pull updates from github every day. 

in `crontab -e`:

```
0 9 * * * ~/dotfiles/pull_dotfiles.sh
```
or if you're using this on CERN lxplus, you should use `acrontab -e`:
```
0 9 * * * lxplus.cern.ch ~/dotfiles/pull_dotfiles.sh
```
For more information about acrontab on lxplus, [see here](http://information-technology.web.cern.ch/services/fe/afs/howto/authenticate-processes).

For security, make sure that `dotfiles/pull_dotfiles.sh` has permissions `-rxwr--r--` (chmod 744).

The cron script is written with the assumption you are using a public/private key combo to interact with your repo. If you want cron to be able to use your private key in order to pull from GitHub, the key must already be present within an ssh-agent when the cron job starts running. If the key is not present in ssh-agent, the pull will fail.

Essentially, once you start an ssh-agent, the process never exits (unless you explicitly kill it, or you restart your computer). What you should do is save the PID of the ssh-agent process running on your machine in a file called `~/.ssh/environment`, and then have cron use this ssh-agent stored in `environment` for authentication.  

`pull_dotfiles.sh`:
```bash
#!/bin/bash

/bin/echo "git pull updates from dotfiles.git"

SSH_ENV="$HOME/.ssh/environment"

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null
else
    echo "No ssh-agent present. Create an agent, save its PID in .ssh/enviornment, and make sure it is running with the right ssh key for github."
    exit 1
fi

cd ~/dotfiles/
git pull origin master
```





