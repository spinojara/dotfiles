{
  config,
  pkgs,
  lib,
  inputs,
  nixGL,
  pkgs-clickhouse,
  ...
}:
{
  home.pointerCursor = {
      gtk.enable = true;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
  fonts.fontconfig.enable = true;

  nixGL = {
    packages = nixGL.packages; # you must set this or everything will be a noop
    defaultWrapper = "GPU_VENDOR"; # choose from nixGL options depending on GPU
  };

  home = {
    username = "isakel";
    homeDirectory = "/home/isakel";
    stateVersion = "25.11";
    packages = with pkgs; [
      (config.lib.nixGL.wrap mesa-demos)
      (config.lib.nixGL.wrap hyprland)
      (config.lib.nixGL.wrap hypridle)
      (config.lib.nixGL.wrap firefox)
      kubectl
      kind
      kubernetes-helm
      hyprshot
      hyprwayland-scanner
      nerd-fonts.symbols-only
      tofi
      waybar
      vim
      foot
      mako
      spotify
      pkgs-clickhouse.clickhouse
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config = {
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };

  programs.home-manager.enable = true;

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
  '';
}
