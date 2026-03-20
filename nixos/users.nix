{ inputs, ... }:

{
  config = {
    users.users.arx = {
      isNormalUser = true;
      description = "Arx";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
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
