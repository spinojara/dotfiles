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

# tmux
cp tmux/tmux.conf /etc/tmux.conf
