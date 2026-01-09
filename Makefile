HOSTNAME := $(shell hostname -s)

INSTALLTARGETS := .vim/vimrc .vim/coc-settings.json .vim/after/syntax/syncolor.vim .vim/after/syntax/c.vim .vim/ftplugin/tex.vim .bashrc .bashrc_profile .inputrc .gitconfig .config/htop/htoprc .tmux.conf .config/waybar/config.jsonc .config/waybar/style.css .config/waybar/color.css .config/foot/foot.ini .config/mako/config .config/tofi/tofi.ini

ifneq ($(filter $(HOSTNAME),gentoo-desktop gentoo-laptop pc64101-2536 lap1h85115chs), )
	INSTALLTARGETS += .config/hypr/gruvbox.conf .config/hypr/hyprlock.conf .config/hypr/common.conf .config/hypr/hyprland.conf .config/hypr/hypridle.conf
endif

INSTALLTARGETS := $(addprefix $(HOME)/,$(INSTALLTARGETS))

install: $(INSTALLTARGETS)

# install targets
$(HOME)/.vim/vimrc: vim/vimrc
	mkdir -p $(HOME)/.vim
	cp $< $@
$(HOME)/.vim/coc-settings.json: vim/coc-settings.json
	mkdir -p $(HOME)/.vim
	cp $< $@
$(HOME)/.vim/after/syntax/syncolor.vim: vim/syncolor.vim
	mkdir -p $(HOME)/.vim/syntax
	cp $< $@
$(HOME)/.vim/after/syntax/c.vim: vim/c.vim
	mkdir -p $(HOME)/.vim/after/syntax
	cp $< $@
$(HOME)/.vim/ftplugin/tex.vim: vim/tex.vim
	mkdir -p $(HOME)/.vim/ftplugin
	cp $< $@

$(HOME)/.bashrc: bash/bashrc
	cp $< $@
$(HOME)/.bashrc_profile: bash/bash_profile
	cp $< $@
$(HOME)/.inputrc: bash/inputrc
	cp $< $@

$(HOME)/.gitconfig: git/gitconfig
	cp $< $@

$(HOME)/.config/htop/htoprc: htop/htoprc
	mkdir -p $(HOME)/.config/htop
	cp $< $@

$(HOME)/.tmux.conf: tmux/tmux.conf
	cp $< $@

$(HOME)/.config/hypr/gruvbox.conf: hypr/gruvbox.conf
	mkdir -p $(HOME)/.config/hypr
	cp $< $@
$(HOME)/.config/hypr/hyprlock.conf: hypr/hyprlock.conf
	mkdir -p $(HOME)/.config/hypr
	cp $< $@
$(HOME)/.config/hypr/common.conf: hypr/common.conf
	mkdir -p $(HOME)/.config/hypr
	cp $< $@
$(HOME)/.config/hypr/hyprland.conf: hypr/$(HOSTNAME)/hyprland.conf
	mkdir -p $(HOME)/.config/hypr
	cp $< $@
$(HOME)/.config/hypr/hypridle.conf: hypr/$(HOSTNAME)/hypridle.conf
	mkdir -p $(HOME)/.config/hypr
	cp $< $@

$(HOME)/.config/waybar/config.jsonc: waybar/config.jsonc
	mkdir -p $(HOME)/.config/waybar
	cp $< $@
$(HOME)/.config/waybar/style.css: waybar/style.css
	mkdir -p $(HOME)/.config/waybar
	cp $< $@
$(HOME)/.config/waybar/color.css: waybar/color.css
	mkdir -p $(HOME)/.config/waybar
	cp $< $@

$(HOME)/.config/foot/foot.ini: foot/foot.ini
	mkdir -p $(HOME)/.config/foot
	cp $< $@

$(HOME)/.config/mako/config: mako/config
	mkdir -p $(HOME)/.config/mako
	cp $< $@

$(HOME)/.config/tofi/tofi.ini: tofi/tofi.ini
	mkdir -p $(HOME)/.config/tofi
	cp $< $@

fetch: $(INSTALLTARGETS)
	cp $(HOME)/.vim/vimrc vim/vimrc
	cp $(HOME)/.vim/coc-settings.json vim/coc-settings.json
	cp $(HOME)/.vim/after/syntax/syncolor.vim vim/syncolor.vim
	cp $(HOME)/.vim/after/syntax/c.vim vim/c.vim
	cp $(HOME)/.vim/ftplugin/tex.vim vim/tex.vim
	cp $(HOME)/.bashrc bash/bashrc
	cp $(HOME)/.bashrc_profile bash/bash_profile
	cp $(HOME)/.inputrc bash/inputrc
	cp $(HOME)/.gitconfig git/gitconfig
	cp $(HOME)/.config/htop/htoprc htop/htoprc
	cp $(HOME)/.tmux.conf tmux/tmux.conf
	cp $(HOME)/.config/waybar/config.jsonc waybar/config.jsonc
	cp $(HOME)/.config/waybar/style.css waybar/style.css
	cp $(HOME)/.config/waybar/color.css waybar/color.css
	cp $(HOME)/.config/foot/foot.ini foot/foot.ini
	cp $(HOME)/.config/mako/config mako/config
	cp $(HOME)/.config/tofi/tofi.ini tofi/tofi.ini
ifneq ($(filter $(HOSTNAME),gentoo-desktop gentoo-laptop pc64101-2536 lap1h85115chs), )
	cp $(HOME)/.config/hypr/gruvbox.conf hypr/gruvbox.conf
	cp $(HOME)/.config/hypr/hyprlock.conf hypr/hyprlock.conf
	cp $(HOME)/.config/hypr/common.conf hypr/common.conf
	cp $(HOME)/.config/hypr/hyprland.conf hypr/$(HOSTNAME)/hyprland.conf
	cp $(HOME)/.config/hypr/hypridle.conf hypr/$(HOSTNAME)/hypridle.conf
endif

.PHONY: install fetch
