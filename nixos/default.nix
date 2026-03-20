{ inputs, ... }:

{
  imports = [
    ./networking.nix
    ./desktop.nix
    ./users.nix
    ./nix-settings.nix
    ./boot.nix
  ];

  # Base NixOS configuration
  _module.args.inputs = inputs;

  # NixOS Module - references other modules via self
  nixosModule = { config, pkgs, lib, ... }: {
    # This module can access inputs through _module.args.inputs
    # and other outputs through the flake outputs
  };
}
