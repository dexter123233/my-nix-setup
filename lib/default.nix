{ inputs, ... }:

{
  # Shared library functions for the dendritic config
  lib = {
    # Helper to create standard user packages list
    mkUserPackages = packages: packages;

    # Standard state version
    stateVersion = "26.05";
  };
}
