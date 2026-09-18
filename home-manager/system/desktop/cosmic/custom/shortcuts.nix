{ config, lib, ... }:

{
  options.system.desktop.cosmic.custom.shortcuts.enable =
    lib.mkEnableOption "Enable COSMIC shortcut customization";

  config =
    lib.mkIf
      (config.system.desktop.cosmic.enable && config.system.desktop.cosmic.custom.shortcuts.enable)
      {
        wayland.desktopManager.cosmic.shortcuts = [
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                "firefox"
              ];
              variant = "Spawn";
            };
            description = config._module.args.cosmicLib.cosmic.mkRON "optional" "Open Firefox";
            key = "Ctrl+Shift+B";
          }
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                "foot"
              ];
              variant = "Spawn";
            };
            description = config._module.args.cosmicLib.cosmic.mkRON "optional" "Open Foot terminal";
            key = "Ctrl+Shift+T";
          }
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" "Close";
            key = "Super+X";
          }
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                (config._module.args.cosmicLib.cosmic.mkRON "enum" "Left")
              ];
              variant = "MoveToOutput";
            };
            key = "Super+Alt+H";
          }
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                (config._module.args.cosmicLib.cosmic.mkRON "enum" "Right")
              ];
              variant = "MoveToOutput";
            };
            key = "Super+Alt+L";
          }

          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                (config._module.args.cosmicLib.cosmic.mkRON "enum" "Left")
              ];
              variant = "Move";
            };
            key = "Super+Ctrl+H";
          }
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                (config._module.args.cosmicLib.cosmic.mkRON "enum" "Right")
              ];
              variant = "Move";
            };
            key = "Super+Ctrl+L";
          }
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                (config._module.args.cosmicLib.cosmic.mkRON "enum" "Up")
              ];
              variant = "Move";
            };
            key = "Super+Ctrl+K";
          }
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                (config._module.args.cosmicLib.cosmic.mkRON "enum" "Down")
              ];
              variant = "Move";
            };
            key = "Super+Ctrl+J";
          }

          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" "PreviousWorkspace";
            key = "Ctrl+Alt+K";
          }
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" "NextWorkspace";
            key = "Ctrl+Alt+J";
          }
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" "MoveToPreviousWorkspace";
            key = "Super+Alt+J";
          }

          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" "MoveToNextWorkspace";
            key = "Super+Alt+K";
          }
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                (config._module.args.cosmicLib.cosmic.mkRON "enum" "BrightnessDown")
              ];
              variant = "System";
            };
            key = "XF86MonBrightnessDown";
          }
          # Lock the screen (Fn+F7)
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                (config._module.args.cosmicLib.cosmic.mkRON "enum" "LockScreen")
              ];
              variant = "System";
            };
            key = "F7";
            description = config._module.args.cosmicLib.cosmic.mkRON "optional" "Lock the screen";
          }
          # Toggle touchpad (F8)
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                (config._module.args.cosmicLib.cosmic.mkRON "enum" "TouchpadToggle")
              ];
              variant = "System";
            };
            key = "F8";
            description = config._module.args.cosmicLib.cosmic.mkRON "optional" "Toggle touchpad";
          }
          # Disable default Super-only launcher binding
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" "Disable";
            key = "Super";
            description = config._module.args.cosmicLib.cosmic.mkRON "optional" "Disable default launcher";
          }

          # Open launcher with Super+A
          {
            action = config._module.args.cosmicLib.cosmic.mkRON "enum" {
              value = [
                (config._module.args.cosmicLib.cosmic.mkRON "enum" "Launcher")
              ];
              variant = "System";
            };
            key = "Super+A";
            description = config._module.args.cosmicLib.cosmic.mkRON "optional" "Open launcher";
          }
        ];
      };
}
