{ config, lib, ... }:

{
  options.system.desktop.niri.custom.outputs.enable =
    lib.mkEnableOption "Enable Niri outputs configuration";

  config =
    lib.mkIf (config.system.desktop.niri.enable && config.system.desktop.niri.custom.outputs.enable)
      {
        programs.niri.settings.outputs = {
          "eDP-1" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 60.0;
            };
            scale = 1;
            # transform omitted: defaults to rotation = 0, flipped = false ("normal")
            position = {
              x = 1920;
              y = 0;
            };
          };
          "DP-1" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 60.0;
            };
            scale = 1;
            position = {
              x = 0;
              y = 0;
            };
          };
          "DP-2" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 60.0;
            };
            scale = 1;
            position = {
              x = 3480;
              y = 0;
            };
          };
        };
      };
}

