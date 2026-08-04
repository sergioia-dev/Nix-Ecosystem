{ inputs, pkgs, ... }:
{
  imports = [
    ../../common/base.nix
    ../../common/hardware/personal-laptop.nix
  ];

  system.desktop = {
    gnome.enable = false; # GNOME Desktop Environment
    cosmic.enable = false; # COSMIC Desktop Environment (System76)
    kdePlasma.enable = false; # KDE Plasma Desktop Environment
    niri.enable = true; # Niri Desktop Environment
  };

  system.shell.zsh.enable = false; # Zsh shell and configuration

  system.profile.battery.setBatteryLimit.enable = false; # Battery charge limit script

  database = {
    mysql.enable = false; # MySQL (MariaDB) database service
    postgresql.enable = false; # PostgreSQL database service
    sqlite.enable = false; # SQLite package (no service)
  };

  tool = {
    docker.enable = false; # Docker container runtime
    nginx.enable = false; # Nginx web server
    openssh.enable = true; # OpenSSH server (port 22, firewall opened)
    overleaf.enable = false; # Overleaf collaborative LaTeX editor
    podman.enable = false; # Podman (with Docker compatibility)
    steam.enable = true; # Steam gaming platform
    tomcat.enable = false; # Apache Tomcat servlet container
    virtManager.enable = false; # Virtual Machine Manager (libvirt)
    waydroid.enable = false; # Waydroid Android container
  };
}
