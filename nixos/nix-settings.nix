{ pkgs, ... }:

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

    environment.systemPackages = with pkgs; [
      home-manager
    ];

    virtualisation.docker.enable = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
