{
  config,
  pkgs,
  lib,
  ...
}: {
  options.system.desktop.gnome.custom.keymaps.enable = lib.mkEnableOption "Enable Gnome Extensions";

  config = lib.mkIf config.system.desktop.gnome.custom.keymaps.enable {
    dconf = {
      settings = {
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Open terminal";
          command = "kgx";
          binding = "<Control><Shift>t";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          name = "Open the Web browser";
          command = "brave";
          binding = "<Control><Shift>b";
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          name = "Disable Touchpad";
          command = "gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled";
          binding = "F10";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
          name = "Enable Touchpad";
          command = "gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled";
          binding = "F11";
        };

        "org/gnome/desktop/input-sources" = {
          xkb-options = ["caps:escape"];
          sources = [(pkgs.lib.gvariant.mkTuple ["xkb" "latam"])];
        };

        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          click-method = "areas";
        };

        "org/gnome/mutter" = {
          dynamic-workspaces = true;
        };

        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = [""];
          toggle-tiled-right = [""];
        };

        "org/gnome/settings-daemon/plugins/media-keys" = {
          screensaver = ["F7"];
        };

        "org/gnome/shell/keybidings" = {
          toggle-quick-setting = ["<Super>q"];
          toggle-message-tray = ["<Super>s"];
        };

        "org/gnome/shell/extensions/paperwm" = {
          show-window-position-bar = false;
          horizontal-margin = 5;
          selection-border-radius-top = 5;
          selection-border-size = 5;
          vertical-margin = 5;
          vertical-margin-bottom = 5;
          window-gap = 10;
        };

        "org/gnome/desktop/wm/keybindings" = {
          close = ["<Super>x"];
        };

        "org/gnome/shell/extensions/paperwm/keybindings" = {
          switch-left = [""];
          switch-right = [""];
          switch-down = [""];
          switch-up = [""];
          swap-monitor-below = [""];
          swap-monitor-above = [""];
          switch-global-left = ["<Super>h"];
          switch-global-right = ["<Super>l"];
          switch-global-down = ["<Super>j"];
          switch-global-up = ["<Super>k"];
          move-left = ["<Control><Super>h"];
          move-right = ["<Control><Super>l"];
          move-up = ["<Control><Super>k"];
          move-down = ["<Control><Super>j"];
          move-monitor-right = ["<Alt><Super>l"];
          move-monitor-left = ["<Alt><Super>h"];
          move-down-workspace = ["<Alt><Super>j"];
          move-up-workspace = ["<Alt><Super>k"];
          switch-monitor-above = ["<Shift><Super>k"];
          switch-monitor-below = ["<Shift><Super>j"];
          switch-monitor-right = ["<Shift><Super>l"];
          switch-monitor-left = ["<Shift><Super>h"];
          switch-up-workspace = ["<Control><Alt>k"];
          switch-down-workspace = ["<Control><Alt>j"];
          move-space-monitor-right = ["<Shift><Control><Alt>l"];
          move-space-monitor-left = ["<Shift><Control><Alt>h"];
          move-space-monitor-above = ["<Shift><Control><Alt>k"];
          move-space-monitor-below = ["<Shift><Control><Alt>j"];
        };
      };
    };
  };
}
