{
  lib,
  config,
  ...
}:
{
  options.console.shell.zsh.enable = lib.mkEnableOption "Enables zsh configuration";

  config = lib.mkIf config.console.shell.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "eastwood";
      };
      initContent = ''
        eval "$(zoxide init zsh --cmd cd)"
        source <(fzf --zsh)
        bindkey -v
        export NIXPKGS_ALLOW_UNFREE=1
        if [ -f "$HOME/Nix-Ecosystem/.env" ]; then
            source "$HOME/Nix-Ecosystem/.env"
        fi
      '';
    };
  };
}
