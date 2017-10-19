#!/bin/bash

#------------------------------------------------------------
#install tmux 2.4 and tmuxp in local t3 directory 
#Note after this, tmux2.4 will be at $HOME/.local/bin/tmux and
#tmuxp will be at $HOME/.local/bin/tmuxp
#In order to acces these you might want to add:
#export PYTHONPATH=$PYTHONPATH:$HOME/.local
#export PATH=$HOME/.local/bin:$PATH
#to your bash_profile/rc 

# -t to install tmux
# -p to install tmuxp 
# -n to install ncurses
# -l to install libevent
# -r remove build dir

#tmuxp: 
#      https://pypi.python.org/pypi/tmuxp
#sample yaml/json files for configs/window/pane management: 
#      https://tmuxp.git-pull.com/en/latest/examples.html
#tmux: 
#     https://github.com/tmux/tmux/wiki


#Some interesting optimization and learning:
#  https://blog.bugsnag.com/tmux-and-vim/ 
#  https://tmuxcheatsheet.com
#  http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/ 

#script inspired by https://gist.github.com/ryin/3106801
#------------------------------------------------------------


#setup 
T=0
P=1 
N=0
L=0
Y=1
R=1

TEMP=`getopt -o t,p,n,l,y,r --long tmux,tmuxp,ncurses,libevent,python3,remove -n 'install_tmux.sh' -- "$@"`
eval set -- "$TEMP"

# extract options and their arguments into variables.
while true ; do
    case "$1" in
        -t|--tmux)     T=1 ; shift ;;
        -p|--tmuxp)    P=1 ; shift ;;
        -n|--ncurses)  N=1 ; shift ;;
        -l|--libevent) L=1 ; shift ;;
        -y|--python3)  Y=1 ; shift ;;
        -r|--remove)   R=1 ; shift ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

# do something with the variables -- in this case the lamest possible one :-)
echo "T = $T"
echo "P = $P"
echo "N = $N"
echo "L = $L"
echo "Y = $Y"
echo "R = $R"

mkdir -p $HOME/tmux_build
cd $HOME/tmux_build

if [ $L = 1 ]
then
  #setup libevent locally, technically a different version is setup here on the t3 but I can't find it... so this works
  wget -O libevent-2.1.8-stable.tar.gz https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
  tar xvzf libevent-2.1.8-stable.tar.gz
  cd libevent-2.1.8-stable
  ./configure --prefix=$HOME/.local --disable-shared
  make && make install
  cd .. 
fi


if [ $N = 1 ]
then
  ##ncurses
  wget -O ncurses.tar.gz http://invisible-island.net/ncurses/#downloads
  tar xvzf ncurses.tar.gz
  cd ncurses
  ./configure --prefix=$HOME/.local
  make && make install
  cd ..
fi


if [ $T = 1 ]
then 
  #install latest tmux working with tmuxp
  wget -O tmux-2.4.tar.gz https://github.com/tmux/tmux/releases/download/2.4/tmux-2.4.tar.gz
  tar xvzf tmux-2.4.tar.gz
  cd tmux-2.4
  ./configure CFLAGS="-I$HOME/.local/include -I/usr/include/ncurses" LDFLAGS="-L$HOME/.local/lib -L/usr/include/ncurses -L$HOME/.local/include"
  CPPFLAGS="-I$HOME/.local/include -I/usr/include/ncurses" LDFLAGS="-static -L$HOME/.local/include -L/usr/include/ncurses -L$HOME/.local/lib" make
  cp tmux $HOME/.local/bin
  cd .. 
fi 

if [ $Y = 1 ]
then 
  wget -O Python-3.4.5.tgz https://www.python.org/ftp/python/3.4.5/Python-3.4.5.tgz
  tar xf Python-3.4.5.tgz
  cd Python-3.4.5
  ./configure --prefix=$HOME/.local
  make && make install
fi

if [ $P = 1 ]
then 
  wget -O tmuxp-1.3.2.tar.gz https://pypi.python.org/packages/80/79/22bf1c58ae5b122f8a2cd1eeec7ec805e097e445e328716e79aa40a34df7/tmuxp-1.3.2.tar.gz#md5=d54711fb559cbf719c5917692c4ea333
  tar xvzf tmuxp-1.3.2.tar.gz
  cd tmuxp-1.3.2
  ##************************************************************************
  ##************************************************************************
  ##THIS SETUP might need changing... the directory might need editing 
  ##but just make the directory its tring to install at
  ##************************************************************************
  ##************************************************************************
  mkdir -p $HOME/.local/lib/python3.4/site-packages/test-easy-install-1290032.write-test
  python3 setup.py build install --prefix $HOME/.local
fi

#remove directory if everything works correctly
if [ $R = 1 ]
then
  rm -rf $HOME/tmux_build
fi 
