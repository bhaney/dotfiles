# Dotfiles

This is a simple manager used to keep dotfiles synched between multiple Linux and macOS machines. Most alises are specific to my names and accounts, so be sure to change `bashrc` and `bash_aliases` to suit your purposes if you decide to use them as a template.


Based heavily on [Michael J. Smalley's dotfiles](https://github.com/michaeljsmalley/dotfiles)

## First time set up

```bash
$ git clone --recursive git@github.com:bhaney/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ source makesymlinks.sh # edit the 'files' variable to only use the dotfiles you want
```

This will move any dotfiles you already have to `dotfiles_old/` and make symlinks from `dotfiles/` to your home directory.

## Setting up Vundle

If you didn't set up with recurive, must do 
```
git submodule init 
git submodule update
```

Then do `vim +PluginInstall +qall`
