{ config, lib, ... }:

{
  options.system.desktop.niri.custom.spawn.enable =
    lib.mkEnableOption "Enable Niri spawn-at-startup configuration";

  config =
    lib.mkIf (config.system.desktop.niri.enable && config.system.desktop.niri.custom.spawn.enable)
      {
        programs.niri.settings.spawn-at-startup = [
          {
            argv = [
              "noctalia-shell"
            ];
          }
        ];
        programs.niri.settings.screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
        programs.niri.settings.animations = { };
      };
}
