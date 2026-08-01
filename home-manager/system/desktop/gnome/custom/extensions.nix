{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  gnome-extensions = with pkgs.gnomeExtensions; [
    removable-drive-menu
    touchpad-switcher
    app-name-indicator
    caffeine
    just-perfection
    top-panel-logo
    paperwm
    battery-health-charging
    vertical-workspaces
    soft-brightness-plus
    dynamic-music-pill
    gsconnect
    cronomix
  ];

  unstable-extensions = with pkgs-unstable.gnomeExtensions; [
    # Add unstable extensions here as needed
  ];
in
{
  options.system.desktop.gnome.custom.extensions.enable =
    lib.mkEnableOption "Enable Gnome Extensions";

  config =
    lib.mkIf
      (config.system.desktop.gnome.enable && config.system.desktop.gnome.custom.extensions.enable)
      {
        home.packages = gnome-extensions ++ unstable-extensions;

        dconf = {
          enable = true;
          settings = {
            "org/gnome/shell" = {
              disable-user-extensions = false;
              enabled-extensions = map (ext: ext.extensionUuid) (gnome-extensions ++ unstable-extensions);
            };
          };
        };
      };
}
