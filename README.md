# Dotfiles

This is a simple manager used to keep dotfiles synched between multiple Linux and macOS machines. Most alises are specific to my names and accounts, so be sure to change `bashrc` and `bash_aliases` to suit your purposes if you decide to use them as a template.


Based heavily on [Michael J. Smalley's dotfiles](https://github.com/michaeljsmalley/dotfiles)

## First time set up

```bash
$ git clone git@github.com:bhaney/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ source makesymlinks.sh # edit the 'files' variable to only use the dotfiles you want
```

This will move any dotfiles you already have to `dotfiles_old/` and make symlinks from `dotfiles/` to your home directory.

## Setting up ssh keys

To use ssh and ssh-agent with git, follow [these instructions](https://help.github.com/articles/connecting-to-github-with-ssh/) by GitHub.

## Cron job for syncing

To get automatic pull updates every day, set up a cron job that runs the script `pull_dotfiles.sh`. 

in `crontab -e`:
```
0 9 * * * ~/dotfiles/pull_dotfiles.sh
```
or if you're using this on CERN lxplus, you should use `acrontab -e`:
```
0 9 * * * lxplus025.cern.ch ~/dotfiles/pull_dotfiles.sh
```
For more information about acrontab on lxplus, [see here](http://information-technology.web.cern.ch/services/fe/afs/howto/authenticate-processes). Unless you have an ssh-agent running on every lxplus node, you should specify the node to run the job on.

For security, make sure that `dotfiles/pull_dotfiles.sh` has permissions `-rxwr--r--` (chmod 744).

### Explaination of cron script

The cron script is written with the assumption you are using ssh to interact with your repo. If you want cron to be able to use your private key in order to pull from GitHub, the key must already be present within an `ssh-agent` when the cron job starts running. If the key is not present in the ssh-agent, the pull will fail.

Starting an `ssh-agent` is easy. Just run the command 
```
eval $(ssh-agent -s)
```
 To then add a private key to the agent, run 
```
ssh-add ~/.ssh/pri_key
``` 
and type in the password associated with the key. `ssh-agent` allows you to not have to type in your key's password every time you use it. Also, once you start the `ssh-agent`, the agent will never exit (unless you explicitly kill the process, or you restart your computer), so this means cron can use it too. 

You can check if an `ssh-agent` is already running by using `ps x`.

Whenever you log out though, the enviormental variables associated with the agent will be erased. What you should do is save the information associated with the `ssh-agent` in a file called `~/.ssh/environment`, and then every time you log in, have your `.bashrc` retreive the information of the (still running) `ssh-agent`, rather than creating a new agent.  This is demontrated in the `bashrc` file.

`pull_dotfiles.sh` explicitly uses the `ssh-agent` saved in the `~/.ssh/environment` file to run the cron job.

```bash
#!/bin/bash

/bin/echo "git pull updates from dotfiles.git"

#ssh-agent variable info stored here
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
```





