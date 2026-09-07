{
  config,
  pkgs-unstable,
  lib,
  ...
}:
let
  forge = pkgs-unstable.gnomeExtensions.forge;
in
{
  options.system.desktop.gnome.custom.forge.enable =
    lib.mkEnableOption "Enable Forge tiling extension";

  config =
    lib.mkIf (config.system.desktop.gnome.enable && config.system.desktop.gnome.custom.forge.enable)
      {
        home.packages = [ forge ];

        dconf = {
          enable = true;
          settings = {
            "org/gnome/shell" = {
              enabled-extensions = lib.mkAfter [ forge.extensionUuid ];
            };

            "org/gnome/shell/extensions/forge" = {
              window-gap-size = 0;
              window-gap-hidden-on-single = false;
              # window-border-radius = 0;
              # border-color = "rgb(0,0,0)";
              # border-width = 1;
              # stacked-tiling = true;
              # tabbed-tiling = true;
              # preview-hint = true;
              # focus-border-toggle = true;
              # show-tab-bar = true;
              # tab-bar-position = 0;
              # stacking-context-menu = true;
              # preview-scale = 10;
              # preview-use-custom-opacity = true;
              # preview-custom-opacity = 90;
              # preview-fade-timeout = 400;
              # preview-target-scale = 100;
              # preview-target-opacity = 100;
              # preview-target-timeout = 0;
              # preview-show-top-layer = true;
              # preview-show-stacked = true;
              # preview-show-tabbed = true;
              # preview-show-floating = true;
              # preview-show-split = true;
              # preview-show-monitor-move = true;
            };

            "org/gnome/shell/extensions/forge/keybindings" = {
              focus-border-toggle = [ "" ];
              window-toggle-float = [ "" ];
              window-toggle-stacked = [ "" ];
              window-toggle-tabbed = [ "" ];
              window-swap-left = [ "<Ctrl><Super>h" ];
              window-swap-right = [ "<Ctrl><Super>l" ];
              window-swap-up = [ "<Ctrl><Super>k" ];
              window-swap-down = [ "<Ctrl><Super>j" ];
              window-move-left = [ "<Alt><Super>h" ];
              window-move-right = [ "<Alt><Super>l" ];
              window-move-up = [ "<Alt><Super>k" ];
              window-move-down = [ "<Alt><Super>j" ];
              window-swap-monitor-left = [ "" ];
              window-swap-monitor-right = [ "" ];
              window-swap-monitor-up = [ "" ];
              window-swap-monitor-down = [ "" ];
              window-move-monitor-left = [ "" ];
              window-move-monitor-right = [ "" ];
              window-move-monitor-up = [ "" ];
              window-move-monitor-down = [ "" ];
              window-toggle-tiled = [ "" ];
              window-corner-resize-tl = [ "" ];
              window-corner-resize-tr = [ "" ];
              window-corner-resize-bl = [ "" ];
              window-corner-resize-br = [ "" ];
              window-resize-left = [ "" ];
              window-resize-right = [ "" ];
              window-resize-up = [ "" ];
              window-resize-down = [ "" ];
              window-toggle-always-float = [ "" ];
              window-toggle-always-stacked = [ "" ];
              window-toggle-always-tabbed = [ "" ];
              window-toggle-always-float-workspace = [ "" ];
              window-toggle-always-float-monitor = [ "" ];
              window-toggle-always-float-above = [ "" ];
              window-toggle-always-float-below = [ "" ];
              window-toggle-always-float-left = [ "" ];
              window-toggle-always-float-right = [ "" ];
              window-toggle-always-float-top = [ "" ];
              window-toggle-always-float-bottom = [ "" ];
              window-toggle-always-float-center = [ "" ];
              window-toggle-always-float-top-left = [ "" ];
              window-toggle-always-float-top-right = [ "" ];
              window-toggle-always-float-bottom-left = [ "" ];
              window-toggle-always-float-bottom-right = [ "" ];
              window-toggle-always-float-top-center = [ "" ];
              window-toggle-always-float-bottom-center = [ "" ];
              window-toggle-always-float-left-center = [ "" ];
              window-toggle-always-float-right-center = [ "" ];
              window-toggle-always-float-center-center = [ "" ];
            };
          };
        };
      };
}
