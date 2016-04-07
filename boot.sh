#!/usr/bin/env zsh
set -e

# get absolute path to dotfiles repo (assumed to be where this script lives,
# but not neccessarily where it's being exec'd from)
REPO_DIR=$(cd $(dirname $0); pwd)
echo "dotfiles REPO_DIR = $REPO_DIR"

# source utility functions
. $REPO_DIR/util.sh

#########
## Main

## Make sure the dotfiles repo is clean
# be sure this is commented out during development!
# git reset --hard HEAD

# link dotfiles
MK_DOT="ghci gitconfig tmux.conf vim zsh vim/vimrc zsh/zshrc zsh/zshrc_alias"

echo "Linking dotfiles"
for file in $(echo $MK_DOT)
do
    dest="$HOME/.$(basename $file)"
    if [ -h $dest ]; then
        echo "removing symlink $dest"
        rm $dest
    elif [ -f $dest ] || [ -d $dest ]; then
        echo "moving file/dir $dest to $dest.OLD"
        mv $dest $dest.OLD
    fi
    echo "linking $REPO_DIR/$file to $dest"
    ln -s $REPO_DIR/$file $dest
done

echo "Booting vim..."
pushd $HOME/.vim > /dev/null
zsh boot.sh
popd > /dev/null

clone_home oh-my-zsh   http://github.com/robbyrussell/oh-my-zsh.git
clone_home tmux-status http://github.com/benjaminfjones/tmux-status.git

echo
echo "Installation done!"
echo "Don't forget:"
echo
echo "  * chsh /bin/zsh"
echo "  * cp ./gitconfig.example to ./gitconfig and fill in details"
echo
