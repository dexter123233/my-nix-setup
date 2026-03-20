{
  description = "Arx's NixOS Configuration - Dendritic Pattern";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
    in
    {
      inherit lib;

      nixosConfigurations.nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ./nixos
          ./hosts/hardware-configuration.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.arx = {
              home = {
                username = "arx";
                homeDirectory = "/home/arx";
                stateVersion = "26.05";
              };

              home.sessionVariables = {
                ANTHROPIC_API_KEY_FILE = "/home/arx/.secrets/anthropic-api-key";
              };
            };
          }
        ];
      };
    };
}
