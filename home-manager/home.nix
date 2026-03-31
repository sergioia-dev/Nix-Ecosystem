{
  config,
  lib,
  ...
}: {
  imports = [
    ./app/appBundle.nix
    ./console/consoleBundle.nix
    ./development/developmentBundle.nix
    ./system/systemBundle.nix
  ];

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
        ideavim.enable =
          lib.mkIf (
            config.development.IDE.jetbrains.intellij.enable
            || config.development.IDE.jetbrains.android-studio.enable
          )
          true;

        intellij.enable = false;
        android-studio.enable = false;
      };
      vscode.enable = false;
      helix.enable = false;
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

    shell = {
      bash.enable = false;
      zsh.enable = true;
      tools.enable = lib.mkDefault true;
    };
  };

  app = {
    browser = {
      brave.enable = true;
      firefox.enable = false;
    };

    infomatic = {
      gradia.enable = true;
      planify.enable = true;
      only-office.enable = true;
      teams.enable = false;
      mendeley.enable = false;
      video-editing.enable = false;
      affine.enable = true;
    };

    music = {
      spotify.enable = false;
      spotube.enable = false;
      gapless.enable = false;
    };

    other = {
      tangram.enable = false;
      discord.enable = false;
      ferdium.enable = false;
      element.enable = false;
    };
  };

  system = {
    desktop.gnome.enable = true;
  };

  home = {
    username = "k1";
    homeDirectory = "/home/k1";
    stateVersion = "25.11";
  };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
