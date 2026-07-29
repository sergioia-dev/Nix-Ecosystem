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
        resurrect
        sensible
      ];
    };
  };
}
