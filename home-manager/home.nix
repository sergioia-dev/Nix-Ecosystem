{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./app/appBundle.nix
    ./console/consoleBundle.nix
    ./development/developmentBundle.nix
    ./system/systemBundle.nix
    inputs.overleaf.homeManagerModules.default
  ];

  services.overleaf = {
    enable = false;
    port = 8080;
    texlivePackages = with pkgs.texlive; [ combined.scheme-full ];
  };

  development = {
    language = {
      nix.enable = false;
      rust.enable = false;
      typescript.enable = false;
      dart.enable = false;
      java.enable = false;
      python.enable = false;
      cpp.enable = false;
      csharp.enable = false;
      lua.enable = false;
    };

    database = {
      sqlite.enable = false;
      mysql.enable = false;
      postgresql.enable = false;
      mongodb.enable = false;
      redis.enable = false;
    };

    IDE = {
      jetbrains = {
        ideavim.enable = lib.mkIf (
          config.development.IDE.jetbrains.intellij.enable
          || config.development.IDE.jetbrains.android-studio.enable
        ) true;

        intellij.enable = false;
        android-studio.enable = false;
      };
      vscode.enable = false;
      helix.enable = false;
    };

    AI = {
      opencode.enable = true;
      pi.enable = false;
    };

    tool = {
      obsidian.enable = false;
      logseq.enable = false;
      penpot.enable = false;
    };
  };

  console = {
    terminal = {
      kitty.enable = false;
      foot.enable = false;
    };

    multiplexer = {
      herdr.enable = false;
      tmux.enable = true;
    };

    shell = {
      bash.enable = false;
      zsh.enable = true;
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
      only-office.enable = false;
      libreoffice.enable = false;
      foliate.enable = false; # doesn't work well
      affine.enable = false;
      logseq.enable = true;
      geary = {
        enable = true;
        autostart = true;
      };
      wordbook.enable = false;
      teams.enable = false;
      mendeley.enable = true;
      video-editing.enable = false;
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
        enable = true;
        autostart = true;
      };
    };

    other = {
      tangram = {
        enable = false;
        autostart = false;
      };
      secrets.enable = true;
      ferdium.enable = false;
      denaro.enable = false;
    };

  };

  system = {
    desktop.gnome.enable = true;
  };

  home = {
    username = "sia";
    homeDirectory = "/home/sia";
    stateVersion = "26.05";
  };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
