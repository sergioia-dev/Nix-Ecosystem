{
  config,
  lib,
  ...
}:
{
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

    tool = {
      obsidian.enable = false;
      logseq.enable = false;
      penpot.enable = false;
    };
  };

  console = {
    terminal = {
      kitty.enable = false;
      foot.enable = true;
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
      chromium.enable = true;
    };

    infomatic = {
      gradia.enable = true;
      planify.enable = true;
      libreoffice.enable = true;
      foliate.enable = false; # doesn't work well
      affine.enable = true;
      geary.enable = true;
      wordbook.enable = true;
      only-office.enable = false;
      teams.enable = false;
      mendeley.enable = true;
      video-editing.enable = false;
    };

    music = {
      spotify.enable = false;
      spotube.enable = false;
      gapless.enable = true;
    };

    other = {
      signal.enable = true;
      tangram.enable = false;
      discord.enable = true;
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
    stateVersion = "26.05";
  };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
