{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.system.desktop.gnome.services.exclude.enable = lib.mkEnableOption "Enable Gnome Extensions";

  config = lib.mkIf config.system.desktop.gnome.services.exclude.enable {
    environment.gnome.excludePackages = with pkgs; [
      baobab # disk usage analyzer
      cheese # photo booth
      epiphany # web browser
      simple-scan # document scanner
      yelp # help viewer
      file-roller # archive manager
      gnome-characters
      gnome-font-viewer
      gnome-logs
      gnome-music
      gnome-photos
      gnome-screenshot
      gnome-system-monitor
      gnome-weather
      gnome-disk-utility
      gnome-connections
      gnome-text-editor
      gnome-tour
      gnome-terminal
      gnome-clocks
      geary
      # evince # document viewer
      # gnome-console
      # gnome-maps
      # gnome-contacts
    ];

    services.xserver.excludePackages = with pkgs; [ xterm ];
  };
}
