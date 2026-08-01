{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.system.desktop.cosmic.custom.keymaps.enable = lib.mkEnableOption "Enable Cosmic Keymaps";

  config =
    lib.mkIf (config.system.desktop.cosmic.enable && config.system.desktop.cosmic.custom.keymaps.enable)
      {
        xdg.configFile."cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom" = {
          text = ''
            {
                (
                    modifiers: [
                        Super,
                    ],
                    key: "b",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "x",
                ): Close,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "h",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                        Shift,
                    ],
                    key: "j",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                    ],
                    key: "l",
                ): MoveToOutput(Right),
                (
                    modifiers: [
                        Super,
                        Alt,
                    ],
                    key: "Right",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "1",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                    ],
                    key: "Right",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                    ],
                    key: "k",
                ): Move(Up),
                (
                    modifiers: [
                        Super,
                        Ctrl,
                        Shift,
                    ],
                    key: "Left",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "g",
                ): Disable,
                (
                    modifiers: [
                        Ctrl,
                        Alt,
                    ],
                    key: "k",
                ): PreviousWorkspace,
                (
                    modifiers: [
                        Alt,
                    ],
                    key: "F4",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                    ],
                    key: "j",
                ): Move(Down),
                (
                    modifiers: [
                        Super,
                    ],
                    key: "t",
                ): Disable,
                (
                    modifiers: [
                        Ctrl,
                        Alt,
                        Shift,
                    ],
                    key: "j",
                ): MoveToPreviousWorkspace,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                        Shift,
                    ],
                    key: "Down",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "k",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "Up",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                        Shift,
                    ],
                    key: "k",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "slash",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "Tab",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                    ],
                    key: "k",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                ): System(Launcher),
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "2",
                ): Disable,
                (
                    modifiers: [],
                    key: "F7",
                ): System(LockScreen),
                (
                    modifiers: [
                        Super,
                        Ctrl,
                    ],
                    key: "h",
                ): Move(Left),
                (
                    modifiers: [
                        Super,
                        Alt,
                        Shift,
                    ],
                    key: "Down",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "8",
                ): Disable,
                (
                    modifiers: [],
                    key: "Home",
                ): System(Screenshot),
                (
                    modifiers: [
                        Super,
                        Alt,
                    ],
                    key: "Up",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "j",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "4",
                ): Disable,
                (
                    modifiers: [],
                    key: "XF86TouchpadToggle",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                        Shift,
                    ],
                    key: "Left",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "j",
                ): Focus(Down),
                (
                    modifiers: [
                        Alt,
                    ],
                    key: "Tab",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "Left",
                ): Disable,
                (
                    modifiers: [],
                    key: "F10",
                ): System(TouchpadToggle),
                (
                    modifiers: [
                        Alt,
                        Shift,
                    ],
                    key: "Tab",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "y",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "Tab",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "0",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                    ],
                    key: "Up",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "Down",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "a",
                ): System(AppLibrary),
                (
                    modifiers: [
                        Super,
                        Ctrl,
                        Shift,
                    ],
                    key: "h",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                        Shift,
                    ],
                    key: "l",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "l",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                        Shift,
                    ],
                    key: "j",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "u",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "Up",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                    ],
                    key: "Left",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "Escape",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                        Shift,
                    ],
                    key: "h",
                ): Disable,
                (
                    modifiers: [
                        Ctrl,
                        Shift,
                    ],
                    key: "b",
                    description: Some("Open Browser"),
                ): Spawn("firefox"),
                (
                    modifiers: [
                        Super,
                    ],
                    key: "m",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "Right",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "6",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "Escape",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                        Shift,
                    ],
                    key: "k",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "9",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                        Shift,
                    ],
                    key: "Right",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "f",
                ): Disable,
                (
                    modifiers: [
                        Ctrl,
                        Alt,
                        Shift,
                    ],
                    key: "k",
                ): MoveToNextWorkspace,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                    ],
                    key: "XF86TouchpadToggle",
                ): Disable,
                (
                    modifiers: [
                        Ctrl,
                        Alt,
                    ],
                    key: "j",
                ): NextWorkspace,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                    ],
                    key: "l",
                ): Move(Right),
                (
                    modifiers: [
                        Super,
                        Ctrl,
                        Shift,
                    ],
                    key: "Right",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                    ],
                    key: "h",
                ): MoveToOutput(Left),
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "Right",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                        Shift,
                    ],
                    key: "l",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "q",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "s",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "Left",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "Down",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                    ],
                    key: "Down",
                ): Disable,
                (
                    modifiers: [],
                    key: "XF86LaunchA",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "5",
                ): Disable,
                (
                    modifiers: [],
                    key: "F11",
                ): System(TouchpadToggle),
                (
                    modifiers: [
                        Super,
                        Ctrl,
                        Shift,
                    ],
                    key: "Up",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "3",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                        Shift,
                    ],
                    key: "Up",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Ctrl,
                    ],
                    key: "Down",
                ): Disable,
                (
                    modifiers: [
                        Super,
                        Alt,
                    ],
                    key: "j",
                ): Disable,
                (
                    modifiers: [
                        Ctrl,
                        Shift,
                    ],
                    key: "t",
                    description: Some("Open Terminal"),
                ): Spawn("foot"),
                (
                    modifiers: [
                        Super,
                        Shift,
                    ],
                    key: "7",
                ): Disable,
                (
                    modifiers: [
                        Super,
                    ],
                    key: "0",
                ): Disable,
            }
          '';
        };
      };
}
