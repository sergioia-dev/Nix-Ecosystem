# karere.nix – Home Manager module for Karere WhatsApp client
{
  pkgs-unstable,
  lib,
  config,
  ...
}:

let
  cfg = config.app.messaging.karere; # shorthand for option path
in
{
  options.app.messaging.karere = {
    enable = lib.mkEnableOption "Enable Karere, a GTK4 WhatsApp client";
    autostart = lib.mkEnableOption "Autostart Karere on GNOME login";
  };

  # ----- Configuration -----
  config = lib.mkIf cfg.enable {
    # Install the package
    home.packages = [ pkgs-unstable.karere ];

    # Write the autostart .desktop file only if autostart is enabled
    xdg.configFile."autostart/karere.desktop" = lib.mkIf cfg.autostart {
      text = ''
        [Desktop Entry]
        Type=Application
        Name=Karere
        Comment=WhatsApp Client
        Exec=${pkgs-unstable.karere}/bin/karere
        Icon=karere
        Terminal=false
        X-GNOME-Autostart-enabled=true
      '';
    };
  };
}
