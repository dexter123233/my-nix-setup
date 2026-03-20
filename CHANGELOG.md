# Changelog

All notable changes to this NixOS configuration.

## [2.0.0] - 2026-03-20

### Added
- **Dendritic Pattern Implementation**
  - Complete restructure using flake-parts modules
  - Auto-import with import-tree
  - Modular nixos/ directory with reusable components
  - Host-specific configurations in hosts/
  - Shared library functions in lib/
  - Comprehensive documentation (README.md)

### Structure Changes
- `nixos/` - Reusable NixOS modules (networking, desktop, users, nix-settings, boot)
- `hosts/` - Host-specific configurations
- `packages/` - Custom packages as flake outputs
- `lib/` - Shared library functions

### Best Practices Implemented
- Automatic garbage collection (weekly, delete older than 30d)
- Git version control with GitHub backup
- Flakes for reproducibility

## [1.0.0] - 2026-03-19

### Added
- Initial NixOS configuration
- Budgie desktop environment
- Basic user setup with packages
- Docker support
