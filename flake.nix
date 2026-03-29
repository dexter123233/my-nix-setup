{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-openclaw.url = "github:openclaw/nix-openclaw";
  };

  outputs = { self, nixpkgs, home-manager, nix-openclaw }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            nix-openclaw.homeManagerModules.openclaw
          ];
          home-manager.users.arx = import ./home.nix;
        }
      ];
    };
  };
}
