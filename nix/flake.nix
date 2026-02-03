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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixGL,
    ...
  }: let
    system = "x86_64-linux";
    pkgsConfig = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
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
      };
      modules = [
        ./home.nix
      ];
    };
  };
}
