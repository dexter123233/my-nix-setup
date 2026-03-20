# Dendritic NixOS Configuration

This repository implements the **Dendritic Pattern** for NixOS configuration, inspired by [Mightyjm's NixOS discourse thread](https://discourse.nixos.org/).

## What is the Dendritic Pattern?

The dendritic pattern transforms your entire Nix project into a collection of **flake-parts modules**. Instead of juggling multiple files with different structures (packages, NixOS modules, shells), every file becomes a consistent flake-parts module.

### Key Benefits

1. **Consistent Structure**: All files follow the same flake-parts module format
2. **No Manual Imports**: Files can reference each other by output name via `self`
3. **Multiple Outputs**: Each module can export packages, NixOS modules, and more
4. **External Access**: All packages and modules are accessible from outside the flake
5. **Scalability**: Easy to organize and expand as your config grows

## Directory Structure

```
nixos-config/
├── flake.nix                 # Main flake with flake-parts setup
├── flake.lock                # Lock file for dependencies
│
├── lib/                      # Shared library functions
│   └── default.nix           # Common utilities (stateVersion, helpers)
│
├── nixos/                    # Reusable NixOS module components
│   ├── default.nix           # Main module (imports all nixos/*)
│   ├── boot.nix              # Bootloader configuration
│   ├── networking.nix        # Network, timezone, i18n
│   ├── desktop.nix           # X11, Budgie, Pipewire
│   ├── users.nix             # User accounts and packages
│   └── nix-settings.nix      # Nix settings, auto-gc, system packages
│
├── hosts/                    # Host-specific configurations
│   ├── default.nix           # Host flake-parts module
│   ├── hardware-configuration.nix
│   └── home.nix              # Home-manager config
│
└── packages/                # Custom packages
    └── default.nix           # Exports system as package
```

## How It Works

### 1. flake-parts Foundation

The `flake.nix` uses flake-parts as the core framework:

```nix
outputs = inputs @ { flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; } {
    # ...
  };
```

### 2. Auto-Import with import-tree

The `import-tree` input automatically imports all `*.nix` files recursively:

```nix
sharedModules = import-tree.importTree {
  inherit inputs;
  include = [ "*.nix" "nixos/**/*.nix" "hosts/**/*.nix" ... ];
};
```

### 3. Dendritic Module Structure

Each file is a flake-parts module that can export:

- **NixOS modules**: Via `config.nixosModule`
- **Packages**: Via `packages.x86_64-linux`
- **Home-manager modules**: Via `homeManagerModules`

### 4. Cross-References

Modules can access each other via `inputs` (passed through `_module.args.inputs`):

```nix
# In users.nix
packages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
  google-chrome
  # ...
];
```

## Usage

### Building the System

```bash
# From the flake directory
sudo nixos-rebuild switch --flake .#nixos

# Or build a specific host
sudo nixos-rebuild switch --flake .#hosts.default.config.system.build.toplevel
```

### Updating Dependencies

```bash
# Update all inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs
```

### Adding New Modules

1. Create a new file in the appropriate directory
2. Follow the flake-parts module structure
3. The file is automatically imported

Example - new module `nixos/gaming.nix`:

```nix
{ inputs, ... }:

{
  config = {
    # Your gaming configuration
    programs.steam.enable = true;
  };
}
```

### Accessing Packages Externally

```bash
# Run a package from the flake
nix run .#arx-packages.config.system.build.toplevel

# Or reference packages in other flakes
nix build github:dexter123233/my-nix-setup#arx-packages
```

## Best Practices (from the video)

1. **Use flakes early**: They improve reproducibility and rollback
2. **Stay declarative**: Avoid `nix-env` and imperative package management
3. **Backup with git**: Always version control your configuration
4. **Auto garbage collection**: Prevent store bloat
5. **Modularize**: Keep config readable by splitting into logical modules
6. **Understand rollback**: Know what is/isn't tracked by NixOS

## Auto Garbage Collection

The config includes automatic GC:

```nix
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};
```

## Troubleshooting

### "attribute missing" errors
- Ensure `flake-parts` is properly set up
- Check that files are in the correct directories

### Import errors
- Files in `nixos/` directory are imported automatically
- Use `inputs` to reference other outputs

## References

- [Dendritic Pattern Discourse Thread](https://discourse.nixos.org/)
- [flake-parts](https://flake.parts/)
- [import-tree](https://github.com/hercules-ci/flake-import-tree)
- [Home Manager](https://nix-community.github.io/home-manager/)

## License

MIT
