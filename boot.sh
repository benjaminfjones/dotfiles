#!/bin/sh

MK_DOT="ghci gitconfig tmux.conf vim zsh vim/vimrc zsh/zshrc"
PWD=$(pwd)

# link dotfiles
for file in $MK_DOT; do
    BNAME=$(basename $file)
    ln -s $PWD/$file $HOME/.$BNAME
done

# boot vim
cd $HOME/.vim
./boot.sh

# install oh-my-zsh
cd $HOME
rm -rf .oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh

# install tmux-status
mkdir -p $HOME/git
cd $HOME/git
git clone https://github.com/benjaminfjones/tmux-status.git

