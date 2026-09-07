{
  config,
  pkgs,
  lib,
  ...
}:
let
  paperwm = pkgs.gnomeExtensions.paperwm;
in
{
  options.system.desktop.gnome.custom.paperwm.enable =
    lib.mkEnableOption "Enable PaperWM tiling extension";

  config =
    lib.mkIf
      (config.system.desktop.gnome.enable && config.system.desktop.gnome.custom.paperwm.enable)
      {
        home.packages = [ paperwm ];

        dconf = {
          enable = true;
          settings = {
            "org/gnome/shell" = {
              enabled-extensions = lib.mkAfter [ paperwm.extensionUuid ];
            };

            "org/gnome/shell/extensions/paperwm" = {
              show-window-position-bar = false;
              horizontal-margin = 5;
              selection-border-radius-top = 5;
              selection-border-size = 5;
              vertical-margin = 5;
              vertical-margin-bottom = 5;
              window-gap = 10;
              disable-topbar-styling = true;
              overview-ensure-viewport-animation = 0;
            };

            "org/gnome/shell/extensions/paperwm/keybindings" = {
              cycle-height = [ "" ];
              new-window = [ "" ];
              switch-left = [ "<Super>h" ];
              switch-right = [ "<Super>l" ];
              switch-down = [ "<Super>j" ];
              switch-up = [ "<Super>k" ];
              swap-monitor-below = [ "" ];
              swap-monitor-above = [ "" ];
              switch-global-left = [ "" ];
              switch-global-right = [ "" ];
              switch-global-down = [ "" ];
              switch-global-up = [ "" ];
              move-left = [ "<Control><Super>h" ];
              move-right = [ "<Control><Super>l" ];
              move-up = [ "<Control><Super>k" ];
              move-down = [ "<Control><Super>j" ];
              move-monitor-right = [ "<Alt><Super>l" ];
              move-monitor-left = [ "<Alt><Super>h" ];
              move-down-workspace = [ "<Alt><Super>j" ];
              move-up-workspace = [ "<Alt><Super>k" ];
              switch-monitor-above = [ "<Shift><Super>k" ];
              switch-monitor-below = [ "<Shift><Super>j" ];
              switch-monitor-right = [ "<Shift><Super>l" ];
              switch-monitor-left = [ "<Shift><Super>h" ];
              switch-up-workspace = [ "<Control><Alt>k" ];
              switch-down-workspace = [ "<Control><Alt>j" ];
              switch-open-window-position = [ "<Shift><Super>r" ];
              move-space-monitor-right = [ "<Shift><Control><Alt>l" ];
              move-space-monitor-left = [ "<Shift><Control><Alt>h" ];
              move-space-monitor-above = [ "<Shift><Control><Alt>k" ];
              move-space-monitor-below = [ "<Shift><Control><Alt>j" ];
            };
          };
        };
      };
}
