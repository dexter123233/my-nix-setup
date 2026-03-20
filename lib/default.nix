{ inputs }:

{
  lib = {
    mkUserPackages = packages: packages;
    stateVersion = "26.05";
  };
}
