# geary.nix – Home Manager module for Geary email client
{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.app.infomatic.geary; # shorthand for option path
in
{
  # ----- Options -----
  options.app.infomatic.geary = {
    enable = lib.mkEnableOption "Enable Geary, an email client";
    autostart = lib.mkEnableOption ''
      Autostart Geary via systemd user service on GNOME login.
      When disabled, the service is still defined but must be started manually.
    '';
  };

  # ----- Configuration -----
  config = lib.mkIf cfg.enable {
    # Install the package
    home.packages = [ pkgs.geary ];

    # Define the systemd user service
    systemd.user.services.geary = {
      Unit = {
        Description = "Geary Mail Client Service";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.geary}/bin/geary --gapplication-service";
        Restart = "on-failure";
        RestartSec = 5;
      };
      # Only enable automatic startup if autostart is true
      Install = lib.mkIf cfg.autostart {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
