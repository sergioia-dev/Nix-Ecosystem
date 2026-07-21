# NixOS System Modules

A modular NixOS configuration using flakes with organized system components, database services, and development tools.

## Quick Start

The configuration uses a **bundle pattern** where modules are organized into categories and enabled/disabled through boolean flags in `/nixos/configuration.nix`.

### Basic Module Usage

```nix
# In /nixos/configuration.nix
system = {
  desktop = {
    gnome.enable = true;     # Enable GNOME desktop
    cosmic.enable = false;    # Disable Cosmic desktop
    kdePlasma.enable = false; # Disable KDE Plasma
  };

  shell = {
    zsh.enable = false;       # Enable ZSH shell
  };

  profile = {
    battery = {
      setBatteryLimit.enable = true;  # Enable battery management
    };
  };
};

database = {
  mysql.enable = false;
  postgresql.enable = false;
  sqlite.enable = false;
};

tool = {
  docker.enable = true;
  nginx.enable = false;
  virtManager.enable = true;
  steam.enable = true;
  tomcat.enable = false;
};
```

## Module System Architecture

### Module Structure

Each module follows this pattern:

```nix
{
  pkgs,
  lib,
  config,
  ...
}: {
  options.category.module.enable = lib.mkEnableOption "Module description";

  config = lib.mkIf config.category.module.enable {
    # Module configuration here
  };
}
```

### Bundle Files

- `system/systemBundle.nix` - Imports all system modules
- `database/databaseBundle.nix` - Imports all database modules
- `tool/toolBundle.nix` - Imports all tool modules

## Available Modules

### System Modules

#### Desktop Environments (Choose ONE)

**GNOME** (`system/desktop/gnome/`)

```nix
system.desktop.gnome.enable = true;
```

- Includes GDM display manager
- Fingerprint authentication support
- Excludes bloatware packages
- Includes `foot` terminal

**Cosmic DE** (`system/desktop/cosmic/`)

```nix
system.desktop.cosmic.enable = true;
```

- System76's modern desktop environment
- Cosmic-greeter display manager
- Wayland-first design

**KDE Plasma** (`system/desktop/kdePlasma/`)

```nix
system.desktop.kdePlasma.enable = true;
```

- Plasma6 desktop environment
- SDDM display manager
- Wayland support enabled

#### Shell

**ZSH** (`system/shell/zsh.nix`)

```nix
system.shell.zsh.enable = true;
```

- Replaces bash with ZSH for user `k1`

#### System Profiles

**Battery Management** (`system/profile/battery/`)

```nix
system.profile.battery.setBatteryLimit.enable = true;
```

- Creates `set-battery-limit` command
- Usage: `set-battery-limit 60` (sets 60% charge limit)
- Validates input range (1-90%)

### Database Modules

#### MySQL/MariaDB (`database/mysql/`)

```nix
database.mysql.enable = true;
```

- Enables MariaDB server
- Uses stable MariaDB package

#### PostgreSQL (`database/postgresql/`)

```nix
database.postgresql.enable = true;
```

- Creates `nixdocs` database
- Creates user `k1` with password `2110`
- Grants all privileges on `nixdocs` database

#### SQLite (`database/sqlite/`)

```nix
database.sqlite.enable = true;
```

- Installs SQLite CLI tools system-wide

#### Bundle Option

```nix
database.enableAll = true;  # Enables MySQL + PostgreSQL
```

### Tool Modules

#### Docker (`tool/docker.nix`)

```nix
tool.docker.enable = true;
```

- Enables Docker daemon
- Adds user `k1` to `docker` group

#### Nginx (`tool/nginx.nix`)

```nix
tool.nginx.enable = true;
```

- Enables Nginx web server
- Pre-configured for local development

#### Virt-Manager (`tool/virt-manager.nix`)

```nix
tool.virtManager.enable = true;
```

- Complete virtualization stack
- Includes libvirtd daemon
- USB redirection support

#### Steam (`tool/steam.nix`)

```nix
tool.steam.enable = true;
```

- Gaming platform client
- Requires `allowUnfree = true`

#### Tomcat (`tool/tomcat.nix`)

```nix
tool.tomcat.enable = true;
```

- Java web application server
- Apache Tomcat container

## Configuration Examples

### Basic Desktop Setup

```nix
system.desktop.gnome.enable = true;
system.shell.zsh.enable = true;
tool.docker.enable = true;
database.mysql.enable = false;
```

### Development Environment

```nix
system.desktop.kdePlasma.enable = true;
system.shell.zsh.enable = true;
tool.docker.enable = true;
tool.nginx.enable = true;
database.postgresql.enable = true;
database.mysql.enable = true;
```

### Gaming Setup

```nix
system.desktop.gnome.enable = true;
tool.steam.enable = true;
tool.virtManager.enable = true;
```

### Server Configuration

```nix
# No desktop environment
tool.docker.enable = true;
tool.nginx.enable = true;
database.enableAll = true;
```

## Applying Changes

### Apply Configuration

```bash
sudo nixos-rebuild switch --flake .#k1
```

### Apply with Cache Update

```bash
sudo nix flake update
sudo nixos-rebuild switch --flake .#k1
```

### Test Configuration

```bash
sudo nixos-rebuild test --flake .#k1
```

## Important Notes

- **Only enable ONE desktop environment** at a time
- **Unfree packages** required for Steam (`nixpkgs.config.allowUnfree = true;`)
- **User configuration** is hardcoded for user `k1` in some modules
- **Virtualization** requires additional network setup after enable:
  ```bash
  sudo virsh net-start default
  ```

## File Structure

```
nixos/
├── configuration.nix          # Main configuration file
├── system/
│   ├── systemBundle.nix       # System module imports
│   ├── desktop/               # Desktop environments
│   │   ├── gnome/
│   │   ├── cosmic/
│   │   └── kdePlasma/
│   ├── hardware/              # Hardware configuration
│   ├── profile/               # System profiles (battery, etc.)
│   └── shell/                 # Shell configurations
├── database/
│   ├── databaseBundle.nix     # Database module imports
│   ├── mysql/
│   ├── postgresql/
│   └── sqlite/
└── tool/
    ├── toolBundle.nix         # Tool module imports
    ├── docker.nix
    ├── nginx.nix
    ├── virt-manager.nix
    ├── steam.nix
    └── tomcat.nix
```

Each module can be used independently by importing it directly or through the bundle system.