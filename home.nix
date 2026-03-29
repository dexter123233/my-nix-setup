{ config, pkgs, ... }:
{
  home.username = "arx";
  home.homeDirectory = "/home/arx";
  home.stateVersion = "26.05";
  # programs.openclaw = {
  #   enable = true;
  #   documents = /home/arx/code/openclaw-local/documents;
  # };
  home.sessionVariables = {
    ANTHROPIC_API_KEY_FILE = "/home/arx/.secrets/anthropic-api-key";
  };
  programs.home-manager.enable = true;
}
