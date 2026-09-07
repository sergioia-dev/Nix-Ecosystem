{ config, lib, inputs, ... }:

{
  imports = [
    ../../app/appBundle.nix
    ../../console/consoleBundle.nix
    ../../development/developmentBundle.nix
    ../../system/systemBundle.nix
    inputs.overleaf.homeManagerModules.default
    inputs.noctalia.homeModules.default
    inputs.niri.homeModules.niri
  ];

  development = {
    IDE = {
      jetbrains = {
        intellij.enable = false;
        android-studio.enable = false;
        ideavim.enable = false;
      };
      vscode.enable = false;
      helix.enable = false;
    };

    AI = {
      opencode.enable = false;
    };

    tool = {
      penpot.enable = true;
      postman.enable = true;
      dbeaver.enable = true;
    };
  };

  console = {
    terminal = {
      kitty.enable = false;
      foot.enable = true;
    };

    multiplexer = {
      herdr.enable = false;
      tmux.enable = true;
    };

    shell = {
      bash.enable = true;
      zsh.enable = false;
      tools.enable = lib.mkDefault true;
    };
  };

  app = {
    browser = {
      brave.enable = false;
      firefox.enable = true;
      chromium.enable = false;
    };

    infomatic = {
      gradia.enable = false;
      planify.enable = true;
      only-office.enable = true;
      libreoffice.enable = false;
      foliate.enable = false; # doesn't work well
      affine.enable = false;
      logseq.enable = true;
      wordbook.enable = false;
      teams.enable = false;
      mendeley.enable = true;
      obs-studio.enable = false;
      thunderbird.enable = false;
    };

    music = {
      spotify.enable = false;
      spotube.enable = false;
      gapless.enable = true;
    };

    messaging = {
      telegram.enable = true;
      discord.enable = false;
      element.enable = false;
      signal.enable = false;
      karere = {
        enable = false;
        autostart = true;
      };
    };

    other = {
      localsend.enable = true;
      overleaf.enable = false;
      secrets.enable = true;
      ferdium.enable = false;
      denaro.enable = false;
      tangram = {
        enable = false;
        autostart = false;
      };
    };
  };

  system = {
    desktop = {
      gnome = {
        enable = false;
        custom = {
          extensions.enable = true;
          theme.enable = true;
          keymaps.enable = true;
          paperwm.enable = false;
          forge.enable = false;
          simple-tiling.enable = true;
        };
        apps = {
          geary = {
            enable = true;
            autostart = true;
          };
        };
      };

      niri = {
        enable = false;
        noctalia.enable = true;
        custom = {
          outputs.enable = true;
          binds.enable = true;
          input.enable = true;
          layout.enable = true;
          spawn.enable = true;
          others.enable = true;
        };
      };
    };
  };

  wayland.desktopManager.cosmic = {
    enable = true;

    appearance.theme = {
      mode = "dark";
      dark.accent = {
        red = 0.3882353;
        green = 0.8156863;
        blue = 0.8745098;
        alpha = 1.0;
      };
    };

    configFile."com.system76.CosmicComp" = {
      version = 1;
      entries = {
        border = {
          width = 2;
          radius = 4;
        };
        xkb_config = {
          layout = "us";
          variant = "";
          options = null;
          repeat_delay = 600;
          repeat_rate = 25;
          rules = "";
        };
      };
    };

    stateFile."com.system76.CosmicBackground" = {
      version = 1;
      entries = {
        wallpapers = [
          {
            source = {
              value = [ "/home/sia/Nix-Ecosystem/assets/rose-pine-nix.webp" ];
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

  home = {
    username = "sia";
    homeDirectory = "/home/sia";
    stateVersion = "26.05";
  };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}