#!/bin/sh

if [ ! -d bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle.vim
else
    cd bundle/Vundle.vim
    git pull
fi

if [ ! -d swap ]; then
    mkdir swap
fi

vim +BundleInstall +qa
