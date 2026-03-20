{ inputs, pkgs, ... }:

{
  config = {
    services.xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    services.desktopManager.budgie.enable = true;
    console.keyMap = "us";

    services.logind.settings.Login.HandleLidSwitch = "ignore";
    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    environment.systemPackages = with pkgs; [
      telegram-desktop
    ];
  };
}
