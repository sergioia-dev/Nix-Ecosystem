{ config, lib, ... }:

{
  options.system.desktop.niri.custom.others.enable =
    lib.mkEnableOption "Enable Niri outputs configuration";

  config =
    lib.mkIf (config.system.desktop.niri.enable && config.system.desktop.niri.custom.others.enable)
      {
        programs.niri.settings = {
          hotkey-overlay = {
            skip-at-startup = true;
          };

          switch-events = {
            lid-close.action.spawn = "noctalia-shell ipc call lockScreen lock";
          };
        };
      };
}
