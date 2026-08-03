{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.system.desktop.niri.custom.binds.enable =
    lib.mkEnableOption "Enable Niri keybindings configuration";

  config =
    lib.mkIf (config.system.desktop.niri.enable && config.system.desktop.niri.custom.binds.enable)
      {
        programs.niri.settings.binds = {
          "Ctrl+Shift+T" = {
            hotkey-overlay.title = "Open a Terminal: Foot";
            action.spawn = lib.getExe pkgs.foot;
          };
          "Mod+A" = {
            hotkey-overlay.title = "Run an Application";
            action.spawn-sh = [ "noctalia-shell ipc call launcher toggle" ];
          };
          "Mod+Q" = {
            hotkey-overlay.title = "Toggles quicksettings";
            action.spawn-sh = [ "noctalia-shell ipc call controlCenter toggle" ];
          };
          "F7" = {
            hotkey-overlay.title = "Launches the LockScreen";
            action.spawn-sh = [ "noctalia-shell ipc call lockScreen lock" ];
          };
          "Mod+N" = {
            hotkey-overlay.title = "Launches the LockScreen";
            action.spawn-sh = [ "noctalia-shell ipc call notifications toggleHistory" ];
          };
          "Ctrl+Shift+B" = {
            hotkey-overlay.title = "Open Browser: Firefox ";
            action.spawn = lib.getExe pkgs.firefox;
          };
          "XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.1+"
              "-l"
              "1.0"
            ];
          };
          "XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.1-"
            ];
          };
          "XF86AudioMute" = {
            allow-when-locked = true;
            action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];
          };
          "XF86AudioMicMute" = {
            allow-when-locked = true;
            action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SOURCE@"
              "toggle"
            ];
          };
          "XF86AudioPlay" = {
            allow-when-locked = true;
            action.spawn = [
              "playerctl"
              "play-pause"
            ];
          };
          "XF86AudioStop" = {
            allow-when-locked = true;
            action.spawn = [
              "playerctl"
              "stop"
            ];
          };
          "XF86AudioPrev" = {
            allow-when-locked = true;
            action.spawn = [
              "playerctl"
              "previous"
            ];
          };
          "XF86AudioNext" = {
            allow-when-locked = true;
            action.spawn = [
              "playerctl"
              "next"
            ];
          };
          "XF86MonBrightnessUp" = {
            allow-when-locked = true;
            action.spawn-sh = [ "noctalia-shell ipc call brightness increase" ];
          };
          "XF86MonBrightnessDown" = {
            allow-when-locked = true;
            action.spawn = [
              "noctalia-shell"
              "ipc"
              "call"
              "brightness"
              "decrease"
            ];
          };
          "Mod+W" = {
            repeat = false;
            action.toggle-overview = [ ];
          };
          "Mod+X" = {
            repeat = false;
            action.close-window = [ ];
          };
          "Mod+H" = {
            action.focus-column-left = [ ];
          };
          "Mod+J" = {
            action.focus-window-down = [ ];
          };
          "Mod+K" = {
            action.focus-window-up = [ ];
          };
          "Mod+L" = {
            action.focus-column-right = [ ];
          };
          "Mod+Ctrl+H" = {
            action.move-column-left = [ ];
          };
          "Mod+Ctrl+J" = {
            action.move-window-down = [ ];
          };
          "Mod+Ctrl+K" = {
            action.move-window-up = [ ];
          };
          "Mod+Ctrl+L" = {
            action.move-column-right = [ ];
          };
          "Mod+Home" = {
            action.focus-column-first = [ ];
          };
          "Mod+End" = {
            action.focus-column-last = [ ];
          };
          "Mod+Ctrl+Home" = {
            action.move-column-to-first = [ ];
          };
          "Mod+Ctrl+End" = {
            action.move-column-to-last = [ ];
          };
          "Mod+Shift+Left" = {
            action.focus-monitor-left = [ ];
          };
          "Mod+Shift+Down" = {
            action.focus-monitor-down = [ ];
          };
          "Mod+Shift+Up" = {
            action.focus-monitor-up = [ ];
          };
          "Mod+Shift+Right" = {
            action.focus-monitor-right = [ ];
          };
          "Mod+Shift+H" = {
            action.focus-monitor-left = [ ];
          };
          "Mod+Shift+J" = {
            action.focus-monitor-down = [ ];
          };
          "Mod+Shift+K" = {
            action.focus-monitor-up = [ ];
          };
          "Mod+Shift+L" = {
            action.focus-monitor-right = [ ];
          };
          "Mod+Alt+H" = {
            action.move-window-to-monitor-left = [ ];
          };
          "Mod+Alt+L" = {
            action.move-window-to-monitor-right = [ ];
          };
          "Ctrl+Alt+J" = {
            action.focus-workspace-down = [ ];
          };
          "Ctrl+Alt+K" = {
            action.focus-workspace-up = [ ];
          };
          "Mod+Alt+J" = {
            action.move-window-to-workspace-down = [ ];
          };
          "Mod+Alt+K" = {
            action.move-window-to-workspace-up = [ ];
          };
          "Mod+Ctrl+U" = {
            action.move-column-to-workspace-down = [ ];
          };
          "Mod+Ctrl+I" = {
            action.move-column-to-workspace-up = [ ];
          };
          "Mod+Shift+Page_Down" = {
            action.move-workspace-down = [ ];
          };
          "Mod+Shift+Page_Up" = {
            action.move-workspace-up = [ ];
          };
          "Mod+Shift+U" = {
            action.move-workspace-down = [ ];
          };
          "Mod+Shift+I" = {
            action.move-workspace-up = [ ];
          };
          "Mod+WheelScrollDown" = {
            cooldown-ms = 150;
            action.focus-workspace-down = [ ];
          };
          "Mod+WheelScrollUp" = {
            cooldown-ms = 150;
            action.focus-workspace-up = [ ];
          };
          "Mod+Ctrl+WheelScrollDown" = {
            cooldown-ms = 150;
            action.move-column-to-workspace-down = [ ];
          };
          "Mod+Ctrl+WheelScrollUp" = {
            cooldown-ms = 150;
            action.move-column-to-workspace-up = [ ];
          };
          "Mod+WheelScrollRight" = {
            action.focus-column-right = [ ];
          };
          "Mod+WheelScrollLeft" = {
            action.focus-column-left = [ ];
          };
          "Mod+Ctrl+WheelScrollRight" = {
            action.move-column-right = [ ];
          };
          "Mod+Ctrl+WheelScrollLeft" = {
            action.move-column-left = [ ];
          };
          "Mod+Shift+WheelScrollDown" = {
            action.focus-column-right = [ ];
          };
          "Mod+Shift+WheelScrollUp" = {
            action.focus-column-left = [ ];
          };
          "Mod+Ctrl+Shift+WheelScrollDown" = {
            action.move-column-right = [ ];
          };
          "Mod+Ctrl+Shift+WheelScrollUp" = {
            action.move-column-left = [ ];
          };
          "Mod+1" = {
            action.focus-workspace = 1;
          };
          "Mod+2" = {
            action.focus-workspace = 2;
          };
          "Mod+3" = {
            action.focus-workspace = 3;
          };
          "Mod+4" = {
            action.focus-workspace = 4;
          };
          "Mod+5" = {
            action.focus-workspace = 5;
          };
          "Mod+6" = {
            action.focus-workspace = 6;
          };
          "Mod+7" = {
            action.focus-workspace = 7;
          };
          "Mod+8" = {
            action.focus-workspace = 8;
          };
          "Mod+9" = {
            action.focus-workspace = 9;
          };
          "Mod+Ctrl+1" = {
            action.move-column-to-workspace = 1;
          };
          "Mod+Ctrl+2" = {
            action.move-column-to-workspace = 2;
          };
          "Mod+Ctrl+3" = {
            action.move-column-to-workspace = 3;
          };
          "Mod+Ctrl+4" = {
            action.move-column-to-workspace = 4;
          };
          "Mod+Ctrl+5" = {
            action.move-column-to-workspace = 5;
          };
          "Mod+Ctrl+6" = {
            action.move-column-to-workspace = 6;
          };
          "Mod+Ctrl+7" = {
            action.move-column-to-workspace = 7;
          };
          "Mod+Ctrl+8" = {
            action.move-column-to-workspace = 8;
          };
          "Mod+Ctrl+9" = {
            action.move-column-to-workspace = 9;
          };
          "Mod+BracketLeft" = {
            action.consume-or-expel-window-left = [ ];
          };
          "Mod+BracketRight" = {
            action.consume-or-expel-window-right = [ ];
          };
          "Mod+Comma" = {
            action.consume-window-into-column = [ ];
          };
          "Mod+Period" = {
            action.expel-window-from-column = [ ];
          };
          "Mod+R" = {
            action.switch-preset-column-width = [ ];
          };
          "Mod+Shift+R" = {
            action.switch-preset-column-width-back = [ ];
          };
          "Mod+Ctrl+Shift+R" = {
            action.switch-preset-window-height = [ ];
          };
          "Mod+Ctrl+R" = {
            action.reset-window-height = [ ];
          };
          "Mod+F" = {
            action.maximize-column = [ ];
          };
          "Mod+Shift+F" = {
            action.fullscreen-window = [ ];
          };
          "Mod+M" = {
            action.maximize-window-to-edges = [ ];
          };
          "Mod+Ctrl+F" = {
            action.expand-column-to-available-width = [ ];
          };
          "Mod+C" = {
            action.center-column = [ ];
          };
          "Mod+Ctrl+C" = {
            action.center-visible-columns = [ ];
          };
          "Mod+Minus" = {
            action.set-column-width = "-10%";
          };
          "Mod+Equal" = {
            action.set-column-width = "+10%";
          };
          "Mod+Shift+Minus" = {
            action.set-window-height = "-10%";
          };
          "Mod+Shift+Equal" = {
            action.set-window-height = "+10%";
          };
          "Mod+V" = {
            action.toggle-window-floating = [ ];
          };
          "Mod+Shift+V" = {
            action.switch-focus-between-floating-and-tiling = [ ];
          };
          "Print" = {
            action.screenshot = [ ];
          };
          "Ctrl+Print" = {
            action.screenshot-screen = [ ];
          };
          "Alt+Print" = {
            action.screenshot-window = [ ];
          };
          "Mod+Escape" = {
            allow-inhibiting = false;
            action.toggle-keyboard-shortcuts-inhibit = [ ];
          };
          "Mod+Shift+E" = {
            action.quit = [ ];
          };
          "Ctrl+Alt+Delete" = {
            action.quit = [ ];
          };
          "Mod+Shift+P" = {
            action.power-off-monitors = [ ];
          };
        };
      };
}
