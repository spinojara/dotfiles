#!/bin/sh
set -e
set -x

# htop
mkdir -p $HOME/.config/htop
cp htop/htoprc $HOME/.config/htop/htoprc

# bash
cp bash/bash_profile $HOME/.bash_profile

# git
cp git/gitconfig $HOME/.gitconfig

# bash
cp bash/bashrc $HOME/.bashrc

# vim
mkdir -p $HOME/.vim/{ftplugin,after/syntax}
cp vim/vimrc $HOME/.vim
cp vim/{syncolor,c}.vim $HOME/.vim/after/syntax
cp vim/tex.vim $HOME/.vim/ftplugin

# tmux
cp tmux/tmux.conf $HOME/.tmux.conf
