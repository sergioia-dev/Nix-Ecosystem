{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./cosmic-manager.nix
  ];

  options = {
    system.desktop.cosmic = {
      enable = lib.mkEnableOption "Enable COSMIC desktop customization via home-manager";

      appearance = {
        theme = {
          mode = lib.mkOption {
            type = lib.types.nullOr (lib.types.enum [ "dark" "light" ]);
            default = null;
            description = "Theme mode for COSMIC desktop";
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
          description = "Window border width in pixels";
        };
        radius = lib.mkOption {
          type = lib.types.ints.unsigned;
          default = 4;
          description = "Window border radius in pixels";
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
        keymaps.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable custom keymaps for COSMIC";
        };
      };
    };
  };

  config = lib.mkMerge [
    # Define system.desktop.cosmic options for users
    (lib.mkIf config.system.desktop.cosmic.enable {
      system.desktop.cosmic = {
        enable = true;

        appearance.theme = {
          mode = lib.mkDefault "dark";
          accent = lib.mkDefault {
            red = 0.3882353;
            green = 0.8156863;
            blue = 0.8745098;
          };
        };

        wallpaper = {
          file = lib.mkDefault "/home/sia/Nix-Ecosystem/assets/rose-pine-nix.webp";
        };

        window_border = {
          width = lib.mkDefault 2;
          radius = lib.mkDefault 4;
        };

        keymap = {
          layout = lib.mkDefault "us";
          variant = lib.mkDefault "";
        };
      };
    })

    # Map system.desktop.cosmic to wayland.desktopManager.cosmic for cosmic-manager
    (lib.mkIf config.system.desktop.cosmic.enable {
      wayland.desktopManager.cosmic = {
        enable = true;

        appearance.theme = {
          mode = config.system.desktop.cosmic.appearance.theme.mode;
        } // lib.optionalAttrs (config.system.desktop.cosmic.appearance.theme.accent != null) {
          dark.accent = {
            red = config.system.desktop.cosmic.appearance.theme.accent.red;
            green = config.system.desktop.cosmic.appearance.theme.accent.green;
            blue = config.system.desktop.cosmic.appearance.theme.accent.blue;
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
    })
  ];
}