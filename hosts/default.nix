{ inputs, ... }:

{
  # Host-specific NixOS configuration
  # This exports a complete NixOS system configuration

  inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../../nixos
      ./hardware-configuration.nix
      (import ./home.nix { inherit inputs; })
    ];
  };
}
