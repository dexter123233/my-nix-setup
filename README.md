# Dendritic NixOS Configuration

This repository implements the **Dendritic Pattern** for NixOS configuration, inspired by [Mightyjm's NixOS discourse thread](https://discourse.nixos.org/).

## What is the Dendritic Pattern?

The dendritic pattern organizes your Nix project into self-contained modules that can reference each other without manual imports. Each module is focused on a specific concern (networking, desktop, users, etc.).

### Key Benefits

1. **Modular Structure**: Each file handles one concern
2. **No Manual Imports**: Modules in `nixos/` are auto-imported
3. **Scalability**: Easy to add new modules
4. **Shareable**: Export packages and modules for external use
5. **Clear Purpose**: Open any file and immediately understand what it does

## Directory Structure

```
nixos-config/
├── flake.nix                    # Main flake with NixOS config
├── flake.lock                   # Lock file
│
├── nixos/                       # NixOS module components
│   ├── default.nix              # Imports all modules
│   ├── boot.nix                 # Bootloader
│   ├── networking.nix           # Network, timezone, i18n
│   ├── desktop.nix              # X11, Budgie, Pipewire
│   ├── users.nix                # User accounts
│   └── nix-settings.nix         # Nix settings, auto-gc
│
└── hosts/                       # Host-specific
    └── hardware-configuration.nix
```

## How It Works

### 1. Main NixOS Configuration

The `flake.nix` defines the NixOS configuration:

```nix
nixosConfigurations.nixos = lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    home-manager.nixosModules.home-manager
    ./nixos                    # Auto-imports all modules
    ./hosts/hardware-configuration.nix
    { /* home-manager config */ }
  ];
};
```

### 2. Modular Components

Files in `nixos/` are self-contained modules:

```nix
# nixos/networking.nix
{ lib, ... }:

{
  config = {
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;
    # ...
  };
}
```

### 3. Home Manager Integration

User home configuration is defined in the flake:

```nix
home-manager.users.arx = {
  home = {
    username = "arx";
    homeDirectory = "/home/arx";
    stateVersion = "26.05";
  };
  home.sessionVariables = {
    ANTHROPIC_API_KEY_FILE = "/home/arx/.secrets/anthropic-api-key";
  };
};
```

## Usage

### Building

```bash
# Rebuild with the flake
sudo nixos-rebuild switch --flake /path/to/nixos-config

# Or from within the config directory
cd /path/to/nixos-config
sudo nixos-rebuild switch --flake .
```

### Updating

```bash
# Update all flake inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs
```

## Adding New Modules

1. Create a new file in `nixos/`
2. Follow the module structure:

```nix
{ lib, ... }:

{
  config = {
    # Your configuration here
  };
}
```

3. The module is auto-imported by `nixos/default.nix`

## Best Practices

1. **Use flakes** - Better reproducibility and rollback
2. **Stay declarative** - Avoid `nix-env`
3. **Version control** - Git with remote backup
4. **Auto GC** - Configured for weekly cleanup
5. **Modularize** - Keep configs focused and readable

## Auto Garbage Collection

```nix
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};
```

## References

- [Dendritic Pattern - NixOS Discourse](https://discourse.nixos.org/)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)

## License

MIT
