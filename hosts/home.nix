{ inputs }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home.username = "arx";
  home.homeDirectory = "/home/arx";
  home.stateVersion = "26.05";

  home.sessionVariables = {
    ANTHROPIC_API_KEY_FILE = "/home/arx/.secrets/anthropic-api-key";
  };
}
