{ inputs, ... }:
{
  imports = [
    ../../common/base.nix
    ../../common/hardware/work-laptop.nix
  ];

  system = {
    desktop = {
      gnome.enable = false; # GNOME Desktop Environment
      cosmic.enable = false; # COSMIC Desktop Environment (System76)
      kdePlasma.enable = false; # KDE Plasma Desktop Environment
      niri.enable = true; # Niri Desktop Environment
    };

    specialization = {
      server.enable = true;
    };
    shell = {
      zsh.enable = false; # Zsh shell and configuration
    };
  };

  system.profile.battery.setBatteryLimit.enable = true; # Battery threshold (boot service; replaces noctalia plugin)

  database = {
    mysql.enable = false; # MySQL (MariaDB) database service
    postgresql.enable = false; # PostgreSQL database service
    sqlite.enable = false; # SQLite package (no service)
  };

  tool = {
    tailscale = {
      enable = false;
      mode = "client";
    };
    docker.enable = false; # Docker container runtime
    nginx.enable = false; # Nginx web server
    openssh.enable = true; # OpenSSH server (port 22, firewall opened)
    overleaf.enable = false; # Overleaf collaborative LaTeX editor
    podman.enable = false; # Podman (with Docker compatibility)
    steam.enable = false; # Steam gaming platform
    tomcat.enable = false; # Apache Tomcat servlet container
    virtManager.enable = false; # Virtual Machine Manager (libvirt)
    waydroid.enable = false; # Waydroid Android container
  };

}
