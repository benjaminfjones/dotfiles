#!/usr/bin/env bash
#
# Link dotfiles to $HOME, making backups if old ones exist.
#
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
MK_DOT="tmux.conf zsh zsh/zshrc zsh/zshrc_alias tool-versions gitconfig"

echo "Linking dotfiles..."
for file in $(echo $MK_DOT)
do
    dest="$HOME/.$(basename $file)"
    if [ -h "$dest" ]; then
        echo "removing symlink $dest"
        rm "$dest"
    elif [ -f "$dest" ] || [ -d "$dest" ]; then
        echo "moving file/dir $dest to $dest.OLD"
        mv "$dest" "$dest.OLD"
    fi

    src="$REPO_DIR/$file"

    echo "linking $src to $dest"
    ln -s "$src" "$dest"
done

# Neovim config now tracked at: https://github.com/benjaminfjones/kickstart.nvim
# echo "Booting neovim..."
# bash "$REPO_DIR/nvim/boot.sh"

echo "Cloning oh-my-zsh..."
clone_home oh-my-zsh http://github.com/robbyrussell/oh-my-zsh.git

echo
echo "Installation done!"
echo "Don't forget:"
echo
echo "  * chsh /bin/zsh"
echo "  * cp ./gitconfig.example to ./gitconfig and fill in details"
echo
