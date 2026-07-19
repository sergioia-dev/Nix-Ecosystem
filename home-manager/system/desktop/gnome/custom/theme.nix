{
  config,
  pkgs,
  lib,
  ...
}:
let
  gnomeContrastSync = pkgs.writeShellScriptBin "gnome-contrast-sync" ''
    # Ensure gsettings can find its schemas
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:${pkgs.gsettings-desktop-schemas}/share/gsettings-desktop-schemas

    # Monitor GNOME color scheme changes
    ${pkgs.glib}/bin/gsettings monitor org.gnome.desktop.interface color-scheme | while read -r line; do
        # Check if the theme switched to dark mode
        if echo "$line" | grep -q "'prefer-dark'"; then
            ${pkgs.glib}/bin/
            gsettings set org.gnome.desktop.a11y.interface high-contrast true

        else
            ${pkgs.glib}/bin/gsettings set org.gnome.desktop.a11y.interface high-contrast false
        fi
    done
  '';

in
{
  options.system.desktop.gnome.custom.theme.enable = lib.mkEnableOption "Enable Gnome Extensions";

  config = lib.mkIf config.system.desktop.gnome.custom.theme.enable {
    dconf = {
      settings = {
        "org/gnome/desktop/interface" = {
          accent-color = "blue";
          show-battery-percentage = true;
          cursor-theme = "Adwaita";
          enable-hot-corners = false;
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
        };

        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = 5;
        };

        "org/gnome/desktop/a11y/interface" = {
          high-contrast = false;
        };

        "org/gnome/desktop/background" = {
          picture-uri-dark = "file://${../../../../../assets/nix-dark.jpg}";
          picture-uri = "file://${../../../../../assets/nix-light.jpg}";
          picture-options = "center";
          color-shading-type = "solid";
        };

        "org/gnome/shell/extensions/top-panel-logo" = {
          icon-path = "${../../../../../assets/NixLogo.png}";
          icon-size = 25;
          horizontal-padding = 0;
        };

        "org/gnome/shell/extensions/quick-settings-audio-panel" = {
          panel-type = "merged-panel";
          remove-output-volume-slider = true;
          merged-panel-position = "top";
          master-volume-sliders-show-current-device = true;
        };

        "org/gnome/shell/extensions/just-perfection" = {
          overlay-key = false;
          accessibility-menu = false;
          quick-settings-night-light = true;
          quick-settings-airplane-mode = false;
          show-apps-button = false;
        };

        "org/gnome/shell/extensions/Battery-Health-Charging" = {
          indicator-position = 4;
          indicator-position-index = 21;
          skip-threshold-verification = true;
        };

        "org/gnome/Console" = {
          audible-bell = false;
          theme = "auto";
          use-system-font = true;
          font-scale = 1.2;
        };

        "org/gnome/shell/extensions/nightthemeswitcher/time" = {
          manual-schedule = true;
          sunset = 18;
          offset = 0;
          nightthemeswitcher-ondemand-keybiding = [ "" ];
        };

        # PaperWM Extension
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

        # V-Shell Extension
        "org/gnome/shell/extensions/vertical-workspaces" = {
          center-dash-to-ws = true;
          dash-position-adjust = 0;
          dash-position = 3;
          ws-thumbnails-position = 1;
          ws-thumbnails-adjust = 0;
          wst-position-adjust = 0;
          show-wst-labels = 0;
          show-ws-preview-bg = false;
          secondary-ws-thumbnails-position = 3;
          notification-position = 1;
          dash-bg-color = 0;
          dash-bg-opacity = 0;
          close-ws-button-mode = 0;
          ws-switcher-mode = 1;
        };

        # Top Panel Logo Extension
        "org/gnome/shell/extensions/top-panel-logo" = {
          left-click-action = 1;
        };

        # Brightness control for all monitor at the same time
        "org/gnome/shell/extensions/soft-brightness-plus" = {
          use-backlight = true;
        };

        "org/gnome/shell/extensions/dynamic-music-pill" = {
          enable-transparency = true;
          popup-custom-width = 360;
          popup-follow-transparency = true;
          transparency-strength = 10;
          target-container = 2;
          position-mode = 1;
          border-radius = 4;
          visualizer-bar-width = 2;
          visualizer-height = 18;
          visualizer-padding = 13;
          visualizer-style = 2;
          transparency-vis = false;
          scroll-action = "volume";
          action-double-click = "next";
          action-middle-click = "none";
          action-hover = "toggle-menu";
          action-right-click = "toggle-menu";
        };
      };
    };

    systemd.user.services.gnome-contrast-sync = {
      Unit = {
        Description = "Sync GNOME High Contrast mode with Dark Mode";
        After = [ "graphical-session.target" ];
        Partof = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${gnomeContrastSync}/bin/gnome-contrast-sync";
        Restart = "on-failure";
        RestartSec = 5;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
