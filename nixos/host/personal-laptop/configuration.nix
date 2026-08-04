{ inputs, pkgs, ... }: {
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

  # Battery Threshold Control (noctalia plugin): give the user process write access to
  # /sys/class/power_supply/BAT0/charge_control_end_threshold. Declarative equivalent of
  # the plugin's setup_rules.sh (stock script can't run on NixOS: read-only /etc, no /bin).
  users.groups.battery_ctl = { };

  users.users.sia.extraGroups = [ "battery_ctl" ];

  services.udev.extraRules = ''
    # Battery Threshold Control - grants write access to charge_control_end_threshold for battery_ctl group
    SUBSYSTEM=="power_supply", KERNEL=="BAT*", \
        RUN+="${pkgs.coreutils}/bin/chgrp battery_ctl /sys$devpath/charge_control_end_threshold", \
        RUN+="${pkgs.coreutils}/bin/chmod g+w /sys$devpath/charge_control_end_threshold"
  '';

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
