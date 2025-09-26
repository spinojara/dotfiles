#!/bin/bash
set -e
set -x

# htop
mkdir -p $HOME/.config/htop
cp htop/htoprc $HOME/.config/htop/htoprc

# git
cp git/gitconfig $HOME/.gitconfig

# bash
cp bash/bashrc $HOME/.bashrc
cp bash/bash_profile $HOME/.bash_profile
cp bash/inputrc $HOME/.inputrc

# vim
mkdir -p $HOME/.vim/{ftplugin,after/syntax}
cp vim/vimrc $HOME/.vim
cp vim/{syncolor,c}.vim $HOME/.vim/after/syntax
cp vim/tex.vim $HOME/.vim/ftplugin

# tmux
cp tmux/tmux.conf $HOME/.tmux.conf

# hyprland
mkdir -p $HOME/.config/hypr
cp hypr/{gruvbox,hyprlock,common}.conf $HOME/.config/hypr
for PLATFORM in axis-desktop gentoo-desktop gentoo-laptop; do
	if [[ "$HOSTNAME" == "$PLATFORM" ]]; then
		cp hypr/$PLATFORM/* $HOME/.config/hypr
	fi
done

# waybar
mkdir -p $HOME/.config/waybar
cp waybar/{config.jsonc,style.css,color.css} $HOME/.config/waybar

# foot
mkdir -p $HOME/.config/foot
cp foot/foot.ini $HOME/.config/foot

# mako
mkdir -p $HOME/.config/mako
cp mako/config $HOME/.config/mako

# tofi
mkdir -p $HOME/.config/tofi
cp tofi/tofi.ini $HOME/.config/tofi
