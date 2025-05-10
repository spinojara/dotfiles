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
