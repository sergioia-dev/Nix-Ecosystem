{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.system.desktop.cosmic.custom.appearance.enable =
    lib.mkEnableOption "Enable COSMIC appearance customization";

  config =
    lib.mkIf
      (config.system.desktop.cosmic.enable && config.system.desktop.cosmic.custom.appearance.enable)
      {
        home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

        wayland.desktopManager.cosmic.appearance = {
          toolkit = {
            show_minimize = false;
            show_maximize = false;
            interface_density = config._module.args.cosmicLib.cosmic.mkRON "enum" "Compact";
            interface_font = {
              family = "JetBrains Mono Nerd Font";
              stretch = config._module.args.cosmicLib.cosmic.mkRON "enum" "Condensed";
              style = config._module.args.cosmicLib.cosmic.mkRON "enum" "Normal";
              weight = config._module.args.cosmicLib.cosmic.mkRON "enum" "Bold";
            };
            monospace_font = {
              family = "JetBrains Mono Nerd Font";
              stretch = config._module.args.cosmicLib.cosmic.mkRON "enum" "Normal";
              style = config._module.args.cosmicLib.cosmic.mkRON "enum" "Normal";
              weight = config._module.args.cosmicLib.cosmic.mkRON "enum" "Bold";
            };
          };

          theme = {
            light = {
              gaps = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                0
                5
              ];
              active_hint = 2;
              corner_radii = {
                radius_0 = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
                radius_xs = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
                radius_s = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
                radius_m = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
                radius_l = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
                radius_xl = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
              };

              accent = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.831;
                green = 0.224;
                blue = 0.937;
              };

              bg_color = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                alpha = 1.0;
                red = 0.945;
                green = 0.945;
                blue = 0.961;
              };

              neutral_tint = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.945;
                green = 0.945;
                blue = 0.961;
              };

              text_tint = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.275;
                green = 0.310;
                blue = 0.412;
              };

              destructive = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.851;
                green = 0.059;
                blue = 0.224;
              };

              warning = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.929;
                green = 0.557;
                blue = 0.114;
              };

              success = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.259;
                green = 0.627;
                blue = 0.169;
              };

              window_hint = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.118;
                green = 0.400;
                blue = 0.961;
              };
            };

            dark = {
              gaps = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                0
                5
              ];
              active_hint = 2;
              corner_radii = {
                radius_0 = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
                radius_xs = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
                radius_s = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
                radius_m = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
                radius_l = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
                radius_xl = config._module.args.cosmicLib.cosmic.mkRON "tuple" [
                  0.0
                  0.0
                  0.0
                  0.0
                ];
              };

              accent = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.796;
                green = 0.651;
                blue = 0.969;
              };

              bg_color = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                alpha = 1.0;
                red = 0.118;
                green = 0.118;
                blue = 0.180;
              };

              neutral_tint = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.118;
                green = 0.118;
                blue = 0.180;
              };

              text_tint = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.855;
                green = 0.851;
                blue = 0.894;
              };

              destructive = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.953;
                green = 0.537;
                blue = 0.549;
              };

              warning = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.976;
                green = 0.886;
                blue = 0.686;
              };

              success = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.651;
                green = 0.890;
                blue = 0.631;
              };

              window_hint = config._module.args.cosmicLib.cosmic.mkRON "optional" {
                red = 0.796;
                green = 0.651;
                blue = 0.969;
              };
            };

            mode = "dark";
          };
        };
      };
}
