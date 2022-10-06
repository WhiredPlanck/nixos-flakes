{ self, nixpkgs, home-manager, ... }:
nixpkgs.lib.nixosSystem {
  # A lot of times online you will see the use of flake-utils + a
  # function which iterates over many possible systems. My system
  # is x86_64-linux, so I'm only going to define that
  system = "x86_64-linux";
  # Import our old system configuration.nix
  modules = [
    ./configuration.nix
    # Include the results of the hardware scan.
    ./hardware.nix
    # Include Home Manager
    ( import "${home-manager}/nixos" )
  ];
}
