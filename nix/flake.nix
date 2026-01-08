{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:spinojara/nixGL/fix-versionMatch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-clickhouse.url = "github:NixOS/nixpkgs/5c46f3bd98147c8d82366df95bbef2cab3a967ea";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixGL,
    nixpkgs-clickhouse,
    ...
  }: let
    system = "x86_64-linux";
    pkgsConfig = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    pkgs-clickhouse = import nixpkgs-clickhouse {
      inherit system;
      config = pkgsConfig;
    };
    pkgs = import nixpkgs {
      inherit system;
      config = pkgsConfig;
    };
  in {
    homeConfigurations."isakel" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit nixGL;
        inherit pkgs-clickhouse;
      };
      modules = [
        ./home.nix
      ];
    };
  };
}
