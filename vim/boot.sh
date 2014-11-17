#!/bin/sh

if [ ! -d bundle/vundle ]; then
    git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle.vim
else
    cd bundle/vundle
    git pull
fi

if [ ! -d swap ]; then
    mkdir swap
fi

vim +BundleInstall +qa
