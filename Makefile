HOSTNAME := $(shell hostname -s)

INSTALLTARGETS := .vim/vimrc .vim/coc-settings.json .vim/after/syntax/syncolor.vim .vim/after/syntax/c.vim .vim/ftplugin/tex.vim .bashrc .bashrc_profile .inputrc .gitconfig .gitignore .config/htop/htoprc .tmux.conf .config/waybar/config.jsonc .config/waybar/style.css .config/waybar/color.css .config/foot/foot.ini .config/mako/config .config/tofi/tofi.ini .config/home-manager/home.nix .config/home-manager/flake.nix

ifneq ($(filter $(HOSTNAME),gentoo-desktop gentoo-laptop pc64101-2536 lap1h85115chs), )
	INSTALLTARGETS += .config/hypr/gruvbox.conf .config/hypr/hyprlock.conf .config/hypr/common.conf .config/hypr/hyprland.conf .config/hypr/hypridle.conf
endif

INSTALLTARGETS := $(addprefix $(HOME)/,$(INSTALLTARGETS))

RPAREN = (
LPAREN = )
GPU_VENDOR := $(shell \
	for d in /sys/class/drm/card*/device/vendor; do \
		case "$$$(RPAREN)cat $$d$(LPAREN)" in \
			0x10de$(LPAREN) echo nvidia ; exit ;; \
			0x1002$(LPAREN) echo mesa ; exit ;; \
		esac; \
	done )

install: $(INSTALLTARGETS)

# install targets
$(HOME)/.vim/vimrc: vim/vimrc
	mkdir -p $(HOME)/.vim
	install -pm 644 $< $@
$(HOME)/.vim/coc-settings.json: vim/coc-settings.json
	mkdir -p $(HOME)/.vim
	install -pm 644 $< $@
$(HOME)/.vim/after/syntax/syncolor.vim: vim/syncolor.vim
	mkdir -p $(HOME)/.vim/syntax
	install -pm 644 $< $@
$(HOME)/.vim/after/syntax/c.vim: vim/c.vim
	mkdir -p $(HOME)/.vim/after/syntax
	install -pm 644 $< $@
$(HOME)/.vim/ftplugin/tex.vim: vim/tex.vim
	mkdir -p $(HOME)/.vim/ftplugin
	install -pm 644 $< $@

$(HOME)/.bashrc: bash/bashrc
	install -pm 644 $< $@
$(HOME)/.bashrc_profile: bash/bash_profile
	install -pm 644 $< $@
$(HOME)/.inputrc: bash/inputrc
	install -pm 644 $< $@

$(HOME)/.gitconfig: git/gitconfig
	install -pm 644 $< $@
$(HOME)/.gitignore: git/gitignore
	install -pm 644 $< $@

$(HOME)/.config/htop/htoprc: htop/htoprc
	mkdir -p $(HOME)/.config/htop
	install -pm 644 $< $@

$(HOME)/.tmux.conf: tmux/tmux.conf
	install -pm 644 $< $@

$(HOME)/.config/hypr/gruvbox.conf: hypr/gruvbox.conf
	mkdir -p $(HOME)/.config/hypr
	install -pm 644 $< $@
$(HOME)/.config/hypr/hyprlock.conf: hypr/hyprlock.conf
	mkdir -p $(HOME)/.config/hypr
	install -pm 644 $< $@
$(HOME)/.config/hypr/common.conf: hypr/common.conf
	mkdir -p $(HOME)/.config/hypr
	install -pm 644 $< $@
$(HOME)/.config/hypr/hyprland.conf: hypr/$(HOSTNAME)/hyprland.conf
	mkdir -p $(HOME)/.config/hypr
	install -pm 644 $< $@
$(HOME)/.config/hypr/hypridle.conf: hypr/$(HOSTNAME)/hypridle.conf
	mkdir -p $(HOME)/.config/hypr
	install -pm 644 $< $@

$(HOME)/.config/waybar/config.jsonc: waybar/config.jsonc
	mkdir -p $(HOME)/.config/waybar
	install -pm 644 $< $@
$(HOME)/.config/waybar/style.css: waybar/style.css
	mkdir -p $(HOME)/.config/waybar
	install -pm 644 $< $@
$(HOME)/.config/waybar/color.css: waybar/color.css
	mkdir -p $(HOME)/.config/waybar
	install -pm 644 $< $@

$(HOME)/.config/foot/foot.ini: foot/foot.ini
	mkdir -p $(HOME)/.config/foot
	install -pm 644 $< $@

$(HOME)/.config/mako/config: mako/config
	mkdir -p $(HOME)/.config/mako
	install -pm 644 $< $@

$(HOME)/.config/tofi/tofi.ini: tofi/tofi.ini
	mkdir -p $(HOME)/.config/tofi
	install -pm 644 $< $@

$(HOME)/.config/home-manager/flake.nix: nix/flake.nix
	mkdir -p $(HOME)/.config/home-manager
	install -pm 644 $< $@

$(HOME)/.config/home-manager/home.nix: nix/home.nix
	mkdir -p $(HOME)/.config/home-manager
	install -pm 644 $< $@
	sed -i 's/GPU_VENDOR/$(GPU_VENDOR)/g' $@

fetch: $(INSTALLTARGETS)
	install -pm 644 $(HOME)/.vim/vimrc vim/vimrc
	install -pm 644 $(HOME)/.vim/coc-settings.json vim/coc-settings.json
	install -pm 644 $(HOME)/.vim/after/syntax/syncolor.vim vim/syncolor.vim
	install -pm 644 $(HOME)/.vim/after/syntax/c.vim vim/c.vim
	install -pm 644 $(HOME)/.vim/ftplugin/tex.vim vim/tex.vim
	install -pm 644 $(HOME)/.bashrc bash/bashrc
	install -pm 644 $(HOME)/.bashrc_profile bash/bash_profile
	install -pm 644 $(HOME)/.inputrc bash/inputrc
	install -pm 644 $(HOME)/.gitconfig git/gitconfig
	install -pm 644 $(HOME)/.gitignore git/gitignore
	install -pm 644 $(HOME)/.config/htop/htoprc htop/htoprc
	install -pm 644 $(HOME)/.tmux.conf tmux/tmux.conf
	install -pm 644 $(HOME)/.config/waybar/config.jsonc waybar/config.jsonc
	install -pm 644 $(HOME)/.config/waybar/style.css waybar/style.css
	install -pm 644 $(HOME)/.config/waybar/color.css waybar/color.css
	install -pm 644 $(HOME)/.config/foot/foot.ini foot/foot.ini
	install -pm 644 $(HOME)/.config/mako/config mako/config
	install -pm 644 $(HOME)/.config/tofi/tofi.ini tofi/tofi.ini
	install -pm 644 $(HOME)/.config/home-manager/home.nix nix/home.nix
	sed -i 's/"\(nvidia\|mesa\)"/"GPU_VENDOR"/g' nix/home.nix
	install -pm 644 $(HOME)/.config/home-manager/flake.nix nix/flake.nix
ifneq ($(filter $(HOSTNAME),gentoo-desktop gentoo-laptop pc64101-2536 lap1h85115chs), )
	install -pm 644 $(HOME)/.config/hypr/gruvbox.conf hypr/gruvbox.conf
	install -pm 644 $(HOME)/.config/hypr/hyprlock.conf hypr/hyprlock.conf
	install -pm 644 $(HOME)/.config/hypr/common.conf hypr/common.conf
	install -pm 644 $(HOME)/.config/hypr/hyprland.conf hypr/$(HOSTNAME)/hyprland.conf
	install -pm 644 $(HOME)/.config/hypr/hypridle.conf hypr/$(HOSTNAME)/hypridle.conf
endif

.PHONY: install fetch
