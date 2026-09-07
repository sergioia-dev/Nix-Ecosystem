{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  simple-tiling = pkgs-unstable.gnomeExtensions.simple-tiling;
in
{
  options.system.desktop.gnome.custom.simple-tiling.enable =
    lib.mkEnableOption "Enable Simple Tiling extension";

  config =
    lib.mkIf
      (config.system.desktop.gnome.enable && config.system.desktop.gnome.custom.simple-tiling.enable)
      {
        home.packages = [ simple-tiling ];

        dconf = {
          enable = true;
          settings = {
            "org/gnome/shell" = {
              enabled-extensions = lib.mkAfter [ simple-tiling.extensionUuid ];
            };

            "org/gnome/shell/extensions/simple-tiling" = {
              # Add Simple Tiling theme settings here
            };

            "org/gnome/shell/extensions/simple-tiling/keybindings" = {
              # Add Simple Tiling keybindings here
            };
          };
        };
      };
}
