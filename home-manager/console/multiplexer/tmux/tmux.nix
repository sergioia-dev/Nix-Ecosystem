{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.console.multiplexer.tmux.enable =
    lib.mkEnableOption "Enable Tmux multiplexer and its configuration";

  config = lib.mkIf config.console.multiplexer.tmux.enable {
    programs.tmux = {
      enable = true;
      extraConfig = builtins.readFile ./tmux.conf;
      plugins = with pkgs.tmuxPlugins; [
        # Home Manager emits each plugin's extraConfig BEFORE its run-shell,
        # which is required: continuum reads @continuum-restore when it loads.
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-strategy-nvim 'session'
          '';
        }
        {
          plugin = continuum; # must be loaded after resurrect
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '5' # minutes (default 15)
          '';
        }
        sensible
      ];
    };
  };
}
