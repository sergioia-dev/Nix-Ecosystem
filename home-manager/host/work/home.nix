{
  lib,
  ...
}:

{
  imports = [
    ../../app/appBundle.nix
    ../../console/consoleBundle.nix
    ../../development/developmentBundle.nix
    ../../system/systemBundle.nix
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
      penpot.enable = false;
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
      planify.enable = false;
      only-office.enable = false;
      libreoffice.enable = false;
      foliate.enable = false; # doesn't work well
      affine.enable = false;
      logseq.enable = false;
      teams.enable = false;
    };

    music = {
      spotify.enable = false;
      spotube.enable = false;
      gapless.enable = false;
    };

    messaging = {
      telegram.enable = false;
      discord.enable = false;
      element.enable = false;
      signal.enable = false;
      karere = {
        enable = false;
        autostart = true;
      };
    };

    other = {
      localsend.enable = false;
      overleaf.enable = false;
      secrets.enable = false;
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

      cosmic = {
        enable = true;
        custom = {
          appearance.enable = true;
          compositor.enable = true;
          wallpapers.enable = true;
          panels.enable = true;
          shortcuts.enable = true;
        };
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
