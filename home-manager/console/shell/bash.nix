{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.console.shell.bash.enable = lib.mkEnableOption "Enables Bash configurations";

  config = lib.mkIf config.console.shell.bash.enable {
    home = {
      packages = with pkgs; [
        bash-completion
      ];

      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
      };
    };
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        eval "$(zoxide init --cmd cd bash)"
        bind 'set show-all-if-ambiguous on'
        set -o vi
        eval "$(fzf --bash)"
        bind 'TAB:menu-complete'
        bind "set completion-ignore-case on"
        if [ -n "$SSH_CONNECTION" ]; then
            # Remote SSH prompt (adds orange [SSH])
            PS1='\[\033[1;33m\] \[\033[1;32m\][\u]\[\033[1;34m\][\W]\[\033[38;5;208m\][SSH]\[\033[1;31m\]$(__git_ps1 "[%s]") \[\033[0m\]\[\033[1;33m\]$ \[\033[1;37m\]'
        else
            # Your original local prompt
            PS1='\[\033[1;33m\] \[\033[1;32m\][\u]\[\033[1;34m\][\W]\[\033[1;31m\]$(__git_ps1 "[%s]") \[\033[0m\]\[\033[1;33m\]$ \[\033[1;37m\]'
        fi
        if [ -f /usr/share/git/completion/git-prompt.sh ]; then
          source /usr/share/git/completion/git-prompt.sh
        elif [ -f ~/.git-prompt.sh ]; then
          source ~/.git-prompt.sh
        fi
        export NIXPKGS_ALLOW_UNFREE=1
      '';
    };
    home.file = {
      ".git-prompt.sh".source = ../utils/.git-prompt.sh;
    };
  };
}
