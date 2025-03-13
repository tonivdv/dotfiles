#!/bin/sh

if [ ! -d ~/.vim/bundle/Vundle.vim ] ; then
    echo "inside"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Launch vim and run :PluginInstall