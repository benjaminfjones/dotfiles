#!/usr/bin/env zsh
set -e

###################
## Helper Functions

# $1 = short name
# $2 = git clone url
clone_home () {
    echo "Cloning $1..."
    pushd $HOME > /dev/null
    if [ -d $HOME/.$1 ]; then
        pushd $HOME/.$1 > /dev/null
        git pull
        popd > /dev/null
    else
        git clone $2 $HOME/.$1
    fi
    popd > /dev/null
}

###################
## Main

REPO_DIR=$(cd $(dirname $0); pwd)
echo "REPO_DIR = $REPO_DIR"

## Make sure the dotfiles repo is clean
# be sure this is commented out during development!
# git reset --hard HEAD

# link dotfiles
MK_DOT="ghci gitconfig tmux.conf vim zsh vim/vimrc zsh/zshrc"

echo "Linking dotfiles"
for file in $(echo $MK_DOT)
do
    dest="$HOME/.$(basename $file)"
    if [ -f $dest ] || [ -d $dest ]; then
        mv $dest $dest.OLD
    elif [ -h $dest ]; then
        rm $dest
    fi
    ln -s $REPO_DIR/$file $dest
done

echo "Booting vim..."
pushd $HOME/.vim > /dev/null
zsh boot.sh
popd > /dev/null

clone_home oh-my-zsh   http://github.com/robbyrussell/oh-my-zsh.git
clone_home tmux-status http://github.com/benjaminfjones/tmux-status.git

echo "Done!"
