{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  dynamic-music-panel = pkgs.callPackage ../../../../../derivations/dynamic-music-pill {};
in {
  options.system.desktop.gnome.custom.extensions.enable = lib.mkEnableOption "Enable Gnome Extensions";

  config = lib.mkIf config.system.desktop.gnome.custom.extensions.enable {
    home.packages = with pkgs.gnomeExtensions; [
      removable-drive-menu
      gsconnect
      touchpad-switcher
      app-name-indicator
      caffeine
      just-perfection
      top-panel-logo
      paperwm
      battery-health-charging
      light-style
      vertical-workspaces
      dynamic-music-panel
    ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            removable-drive-menu.extensionUuid
            touchpad-switcher.extensionUuid
            app-name-indicator.extensionUuid
            caffeine.extensionUuid
            just-perfection.extensionUuid
            gsconnect.extensionUuid
            top-panel-logo.extensionUuid
            paperwm.extensionUuid
            battery-health-charging.extensionUuid
            light-style.extensionUuid
            vertical-workspaces.extensionUuid
            dynamic-music-panel.extensionUuid
          ];
        };
      };
    };
  };
}
