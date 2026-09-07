{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.cosmic-manager.homeManagerModules.default
  ];

  options.system.desktop.cosmic = {
    enable = lib.mkEnableOption "COSMIC desktop configuration via cosmic-manager";

    theme = {
      mode = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum [ "dark" "light" ]);
        default = null;
        description = "Theme mode for COSMIC";
      };

      accent = lib.mkOption {
        type = lib.types.nullOr (lib.types.submodule {
          options = {
            red = lib.mkOption {
              type = lib.types.float;
              default = 0.0;
            };
            green = lib.mkOption {
              type = lib.types.float;
              default = 0.0;
            };
            blue = lib.mkOption {
              type = lib.types.float;
              default = 0.0;
            };
          };
        });
        default = null;
        description = "Accent color for COSMIC theme";
      };
    };

    wallpaper = {
      file = lib.mkOption {
        type = lib.types.path;
        default = null;
        description = "Wallpaper file path";
      };
    };

    window_border = {
      width = lib.mkOption {
        type = lib.types.ints.unsigned;
        default = 2;
        description = "Window border width";
      };
      radius = lib.mkOption {
        type = lib.types.ints.unsigned;
        default = 4;
        description = "Window border radius";
      };
    };

    keymap = {
      layout = lib.mkOption {
        type = lib.types.str;
        default = "us";
        description = "Keyboard layout";
      };
      variant = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Keyboard variant";
      };
    };

    custom = {
      keymaps = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable custom keymaps";
      };
    };
  };

  config = lib.mkIf config.system.desktop.cosmic.enable {
    wayland.desktopManager.cosmic = {
      enable = true;

      appearance.theme = {
        mode = config.system.desktop.cosmic.theme.mode;
      } // lib.optionalAttrs (config.system.desktop.cosmic.theme.accent != null) {
        dark.accent = config.system.desktop.cosmic.theme.accent // {
          alpha = lib.mkDefault 1.0;
        };
      };

      configFile."com.system76.CosmicComp" = {
        version = 1;
        entries = {
          border = {
            width = config.system.desktop.cosmic.window_border.width;
            radius = config.system.desktop.cosmic.window_border.radius;
          };
        } // lib.optionalAttrs (config.system.desktop.cosmic.keymap.layout != null) {
          xkb_config = {
            layout = config.system.desktop.cosmic.keymap.layout;
            variant = config.system.desktop.cosmic.keymap.variant;
            options = lib.mkDefault null;
            repeat_delay = lib.mkDefault 600;
            repeat_rate = lib.mkDefault 25;
            rules = "";
          };
        };
      };
    } // lib.optionalAttrs (config.system.desktop.cosmic.wallpaper.file != null) {
      stateFile."com.system76.CosmicBackground" = {
        version = 1;
        entries = {
          wallpapers = lib.mkForce [
            {
              source = {
                value = [ config.system.desktop.cosmic.wallpaper.file ];
                variant = "Path";
              };
              output = "all";
              filter_by_theme = true;
              scaling_mode = {
                value = [ { value = [ 1.0 1.0 ]; variant = "tuple"; } ];
                variant = "Fit";
              };
              filter_method = "Lanczos";
              sampling_method = "Alphanumeric";
            }
          ];
        };
      };
    };
  };
}
