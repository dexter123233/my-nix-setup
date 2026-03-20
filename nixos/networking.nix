{ inputs, ... }:

{
  options = {
    networking.hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "Hostname of the machine";
    };
  };

  config = {
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "Asia/Kolkata";

    i18n = {
      defaultLocale = "en_IN";
      extraLocaleSettings = {
        LC_ADDRESS = "en_IN";
        LC_IDENTIFICATION = "en_IN";
        LC_MEASUREMENT = "en_IN";
        LC_MONETARY = "en_IN";
        LC_NAME = "en_IN";
        LC_NUMERIC = "en_IN";
        LC_PAPER = "en_IN";
        LC_TELEPHONE = "en_IN";
        LC_TIME = "en_IN";
      };
    };
  };
}
