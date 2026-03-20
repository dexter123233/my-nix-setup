{ inputs, ... }:

{
  config = {
    programs.firefox.enable = true;
    programs.nix-ld.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      docs.enable = false;
    };

    environment.systemPackages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
      inputs.home-manager.packages.x86_64-linux.default
    ];

    virtualisation.docker.enable = true;

    # Automatic garbage collection (dendritic best practice)
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
