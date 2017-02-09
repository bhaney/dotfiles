# Dotfiles

This is a simple dotfile manager that is used to keep dotfiles synched between multiple macOS and Linux machines. Most alises are specific to my names and accounts, so be sure to change bashrc and bash_aliases to suit your purposes if you decide to use them as a template.

Based heavily on [Michael J. Smalley's dotfiles](https://github.com/michaeljsmalley/dotfiles)

## First time set up

```bash
$ git clone git@github.com:bhaney/dotfiles.git
$ cd ~/dotfiles
$ source makesymlinks.sh # edit the 'files' variable to only use the dotfiles you want
```

This will move any dotfiles you already have to dotfiles_old/ and make symlinks from dotfiles/ to your home directory.

## Cron job for syncing
On each computer where I use these dotfiles, I have a cron job to automatically pull updates from github every day. 

To use ssh with git, you can use [these instructions](https://help.github.com/articles/connecting-to-github-with-ssh/) by GitHub.

in `crontab -e`:

```
0 9 * * * ~/scripts/pull_dotfiles.sh
```

in `scripts/pull_dotfiles.sh`:

```bash
#!/bin/bash

/bin/echo "git pull updates from dotfiles.git"

eval $(ssh-agent -s)
ssh-add ~/.ssh/id_github
cd ~/dotfiles/
git pull origin master
kill $SSH_AGENT_PID
```





