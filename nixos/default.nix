{ ... }:

{
  imports = [
    ./networking.nix
    ./desktop.nix
    ./users.nix
    ./nix-settings.nix
    ./boot.nix
  ];
}
