#!/bin/sh

## Functions

# $1 = short name
# $2 = git clone url
clone_home () {
    echo "Installing $1"
    cd $HOME
    if [ -d $HOME/.$1 ]; then
        cd $HOME/.$1
        git pull
    else
        git clone $2 $HOME/.$1
    fi
}

## Make sure the dotfiles repo is clean
git reset --hard HEAD

MK_DOT="ghci gitconfig tmux.conf vim/ zsh/ vim/vimrc zsh/zshrc"
PWD=$(pwd)

## Each step should cd to the directory it needs

# link dotfiles
echo "Linking dotfiles"
for file in $MK_DOT; do
    BNAME=$(basename $file)
    ln -b -s $PWD/$file $HOME/.$BNAME
done

# boot vim
echo "Booting vim"
cd $HOME/.vim
./boot.sh

clone_home(oh-my-zsh, http://github.com/robbyrussell/oh-my-zsh.git)

clone_home(tmux-status, http://github.com/benjaminfjones/tmux-status.git)

echo "Done."
