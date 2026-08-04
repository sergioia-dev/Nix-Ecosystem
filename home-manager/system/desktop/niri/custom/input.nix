{ config, lib, ... }:

{
  options.system.desktop.niri.custom.input.enable = lib.mkEnableOption "Enable Niri input configuration";

  config = lib.mkIf (config.system.desktop.niri.enable && config.system.desktop.niri.custom.input.enable) {
    programs.niri.settings.input = {
      keyboard = {
        xkb = {
          options = "caps:escape";
        };
      };
      touchpad = {
        tap = true;
        dwt = true;
        natural-scroll = true;
      };
      mouse = { };
      trackpoint = { };
    };

    programs.niri.settings.gestures = {
      hot-corners = {
        enable = false;
      };
    };
  };
}