{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.system.desktop.niri.services.configuration.enable =
    lib.mkEnableOption "Enable Niri session (greetd, waybar, etc.)";

  config = lib.mkIf config.system.desktop.niri.services.configuration.enable {

    environment.systemPackages = with pkgs; [
      wl-clipboard
      nautilus
    ];

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

    programs.niri.enable = true;
    services.gvfs.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = "sia";
        };
      };
    };
  };
}
