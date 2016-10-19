#!/usr/bin/env bash
#
# Link dotfiles to $HOME, making backups if old ones exist. If invoked with -s
# or --simple, file in the 'simple/' directory will be prefered over ones in
# the root of the repository (or subdirs of).
#
set -e

# parse command line args
SIMPLE=""
while [[ $# -ge 1 ]]; do
    key="$1"

    case "$key" in
        -s|--simple)
        echo "Simple installation requested."
        SIMPLE="y"
        shift
        ;;

        *)
        echo "Unrecognized parameter: $key"
        exit 1
        ;;
    esac
done

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
    if [ -h "$dest" ]; then
        echo "removing symlink $dest"
        rm "$dest"
    elif [ -f "$dest" ] || [ -d "$dest" ]; then
        echo "moving file/dir $dest to $dest.OLD"
        mv "$dest" "$dest.OLD"
    fi

    if [[ "$SIMPLE" == "y" && -f "$REPO_DIR/simple/$file" ]]; then
        src="$REPO_DIR/simple/$file"  # link the simple version
    else
        src="$REPO_DIR/$file"  # link the regular version
    fi

    echo "linking $src to $dest"
    ln -s "$src" "$dest"
done

echo "Booting vim..."
pushd $HOME/.vim > /dev/null
zsh boot.sh
popd > /dev/null

if [[ "$SIMPLE" == "y" ]]; then
    echo "Skipping oh-my-zsh and tmux-status..."
else
    echo "Cloning oh-my-zsh and tmux-status..."
    clone_home oh-my-zsh   http://github.com/robbyrussell/oh-my-zsh.git
    clone_home tmux-status http://github.com/benjaminfjones/tmux-status.git
fi

echo
echo "Installation done!"
echo "Don't forget:"
echo
echo "  * chsh /bin/zsh"
echo "  * cp ./gitconfig.example to ./gitconfig and fill in details"
echo
