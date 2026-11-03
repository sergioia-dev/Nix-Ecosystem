{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  daily-dev-tui = inputs.derivations.packages.${pkgs.stdenv.hostPlatform.system}.daily-dev-tui;
  normadocs = inputs.derivations.packages.${pkgs.stdenv.hostPlatform.system}.normadocs;
in
{
  options.console.shell.tools.enable = lib.mkEnableOption "Enable CLI-Tools terminal";

  config = lib.mkIf config.console.shell.tools.enable {
    home.packages = with pkgs; [
      git
      zip
      unzip
      unrar
      ripgrep
      eza
      fzf
      bat
      zoxide
      curl
      delta
      taskwarrior3
      direnv
      nix-direnv
      daily-dev-tui
      normadocs
    ];

    home.shellAliases = {
      unrar = "unrar x";
      cat = "bat --theme='Catppuccin Mocha' --color=always";
      ls = "eza --icons=auto --git";
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.btop = {
      enable = true;
      settings = {
        color_theme = "monokai";
        theme_background = false;
        vim_keys = true;
        rounded_corners = true;
      };
    };
  };
}
