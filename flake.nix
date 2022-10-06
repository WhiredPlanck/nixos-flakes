# Adapted from https://gist.github.com/m1cr0man/8cae16037d6e779befa898bfefd36627
{
  description = "Planck's NixOS configuration";

  inputs = {
    nixpkgs = {
      # Using the nixos-unstable-small branch specifically, which is the
      # closest you can get to following the channel with flakes.
      url = "github:NixOS/nixpkgs/nixos-unstable-small";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Outputs can be anything, but the wiki + some commands define their own
  # specific keys. Wiki page: https://nixos.wiki/wiki/Flakes#Output_schema
  outputs = { self, nixpkgs, home-manager, ... }: {
    # nixosConfigurations is the key that nixos-rebuild looks for.
    nixosConfigurations = {
      # move the core part to default.nix in import math
      legion-y545 = import ./nixos/legion-y545 {
        inherit self nixpkgs home-manager;
      };
    };
  };
}
