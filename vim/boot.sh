#!/bin/sh

if [ ! -d bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git bundle/vundle
else
    cd bundle/vundle
    git pull
fi

if [ ! -d swap ]; then
    mkdir swap
fi

vim +BundleInstall +qa
