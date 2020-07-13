#!/bin/bash

set -ex

BOOT_DIR=$(cd $(dirname $0); pwd)
echo "dotfiles BOOT_DIR = $BOOT_DIR"

# install vim-plug for neovim: https://github.com/junegunn/vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# link init.vim and spell
NVIM_DIR="$HOME/.config/nvim"
if [ -d "$NVIM_DIR" ]; then
    echo "moving ${NVIM_DIR} to ${NVIM_DIR}.OLD"
    mv "${NVIM_DIR}" "${NVIM_DIR}.OLD"
fi

mkdir -p "$NVIM_DIR"
ln -s "$BOOT_DIR/init.vim" "$NVIM_DIR/init.vim"
ln -s "$BOOT_DIR/spell" "$NVIM_DIR/spell"

# install plugins
nvim +PlugInstall +qa
