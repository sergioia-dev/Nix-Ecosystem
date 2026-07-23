{
  pkgs,
  lib,
  config,
  ...
}:
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
      wl-clipboard
      curl
      openssh
    ];

    home.shellAliases = {
      unrar = "unrar x";
      cat = "bat --theme='Catppuccin Mocha' --color=always";
      fm = "xdg-open";
      ls = "eza --icons=auto --git";
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        theme_background = false;
        vim_keys = true;
        rounded_corners = true;
      };
    };
  };
}
