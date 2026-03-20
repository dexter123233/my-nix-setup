{ inputs, ... }:

{
  # Custom packages exported from this flake
  packages.x86_64-linux = {
    arx-packages = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ../nixos ];
    };
  };
}
