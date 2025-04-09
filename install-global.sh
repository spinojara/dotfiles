#!/bin/sh
set -e
set -x

# bash
mkdir -p /etc/bash/bashrc.d
cp bash/bashrc /etc/bash/bashrc.d/bashrc.bash

# vim
mkdir -p /etc/vim
cp vim/vimrc /etc/vim/vimrc.local
mkdir -p /usr/share/vim/vimfiles/after/syntax
cp vim/c.vim /usr/share/vim/vimfiles/after/syntax/c.vim
cp vim/syncolor.vim /usr/share/vim/vimfiles/after/syntax/syncolor.vim
mkdir -p /usr/share/vim/vimfiles/ftplugin
cp vim/tex.vim /usr/share/vim/vimfiles/ftplugin/tex.vim

# tmux
cp tmux/tmux.conf /etc/tmux.conf
