{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.system.desktop.gnome.custom.keymaps.enable = lib.mkEnableOption "Enable Gnome Extensions";

  config =
    lib.mkIf (config.system.desktop.gnome.enable && config.system.desktop.gnome.custom.keymaps.enable)
      {
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
              command = "foot";
              binding = "<Control><Shift>t";
            };

            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
              name = "Open the Web browser";
              command = "firefox";
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
              xkb-options = [ "caps:escape" ];
              sources = [
                (pkgs.lib.gvariant.mkTuple [
                  "xkb"
                  "us"
                ])
              ];
            };

            "org/gnome/shell/app-switcher" = {
              current-workspace-only = false;
            };

            "org/gnome/desktop/peripherals/touchpad" = {
              click-method = "areas";
            };

            "org/gnome/mutter" = {
              dynamic-workspaces = false;
              workspaces-only-on-primary = false;
              overlay-key = "";
            };

            "org/gnome/desktop/wm/preferences" = {
              num-workspaces = 5;
            };

            "org/gnome/mutter/keybindings" = {
              toggle-tiled-left = [ "" ];
              toggle-tiled-right = [ "" ];
            };

            "org/gnome/settings-daemon/plugins/media-keys" = {
              screensaver = [ "F7" ];
            };

            "org/gnome/shell/keybindings" = {
              toggle-quick-settings = [ "<Super>q" ];
              toggle-message-tray = [ "<Super>n" ];
              toggle-application-view = [ "<Super>a" ];
              toggle-overview = [ "<Super>w" ];
              focus-active-notification = [ "" ];
            };

            "org/gnome/desktop/wm/keybindings" = {
              close = [ "<Super>x" ];
            };

          };
        };
      };
}
