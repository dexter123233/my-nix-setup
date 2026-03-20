{
  description = "Arx's NixOS Configuration - Dendritic Pattern";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix.url = "github:numtide/treefmt-nix";

    treefmt = {
      url = "github:numtide/treefmt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree = {
      url = "github:hercules-ci/flake-import-tree";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      perSystem = { config, self', pkgs, ... }: {
        packages = {
          default = self'.packages.arx-packages;
        };
      };

      sharedModules = import-tree.importTree {
        inherit inputs;
        include = [ "*.nix" "nixos/**/*.nix" "hosts/**/*.nix" "home/**/*.nix" "lib/**/*.nix" "packages/**/*.nix" ];
      };
    };
}
