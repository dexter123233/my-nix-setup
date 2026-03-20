{ pkgs, ... }:

{
  config = {
    users.users.arx = {
      isNormalUser = true;
      description = "Arx";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
        google-chrome
        onboard
        zapzap
        opencode
        kitty
        capture
        discord
        llvmPackages.libcxxClang
        docker_29
      ];
    };
  };
}
