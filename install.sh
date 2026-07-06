#!/bin/sh
set -eu

cd "$(dirname "$0")"

link() {
	mkdir -p "$HOME/$(dirname "$2")"
	ln -svf "$PWD/$1" "$HOME/$2"
}

hypr=
case "$(uname -n)" in
gentoo-desktop|gentoo-laptop|pc64101-2536|lap1h85115chs) hypr=1 ;;
esac

mkdir -p "$HOME/.vim/undo"
link vim/vimrc .vim/vimrc
link vim/coc-settings.json .vim/coc-settings.json
link vim/syncolor.vim .vim/after/syntax/syncolor.vim
link vim/c.vim .vim/after/syntax/c.vim
link vim/tex.vim .vim/ftplugin/tex.vim

link bash/bashrc .bashrc
link bash/bash_profile .bash_profile
link bash/inputrc .inputrc

link git/gitconfig .gitconfig
link git/gitignore .gitignore

link htop/htoprc .config/htop/htoprc
# htop rewrites its config on exit, but skips it if owner write permission is missing
chmod 444 htop/htoprc

link tmux/tmux.conf .tmux.conf

link waybar/config.jsonc .config/waybar/config.jsonc
link waybar/style.css .config/waybar/style.css
link waybar/color.css .config/waybar/color.css

link foot/foot.ini .config/foot/foot.ini

link mako/config .config/mako/config

link tofi/tofi.ini .config/tofi/tofi.ini

link nix/flake.nix .config/home-manager/flake.nix
link nix/home.nix .config/home-manager/home.nix

link claude/settings.json .claude/settings.json
link claude/statusline-command.sh .claude/statusline-command.sh

if [ -n "$hypr" ]; then
	link hypr/gruvbox.conf .config/hypr/gruvbox.conf
	link hypr/hyprlock.conf .config/hypr/hyprlock.conf
	link hypr/common.lua .config/hypr/common.lua
	link "hypr/$(uname -n)/hyprland.lua" .config/hypr/hyprland.lua
	link "hypr/$(uname -n)/hypridle.conf" .config/hypr/hypridle.conf
fi
