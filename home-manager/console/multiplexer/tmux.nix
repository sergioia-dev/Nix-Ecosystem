{
  pkgs,
  lib,
  config,
  ...
}:

let
  # Define the plugin locally
  tmux-agent-indicator = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-agent-indicator";
    version = "unstable-2026-07-25";
    src = pkgs.fetchFromGitHub {
      owner = "accessd";
      repo = "tmux-agent-indicator";
      rev = "59061a2ecf2034777cd6d40293e4ade15fd91ae3"; # latest commit on main as of writing
      sha256 = "sha256-Cguan8MKnZZa44Eyl958bF/7dk7PGdI/Wc41Qkd0IdM="; # replace with actual hash after first build
    };
    rtpFilePath = "agent-indicator.tmux";
    meta = {
      description = "Tmux plugin that gives visual feedback for AI agent states";
      homepage = "https://github.com/accessd/tmux-agent-indicator";
      license = lib.licenses.mit;
    };
  };
in
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
        tmux-agent-indicator # add the new plugin
      ];
    };
  };
}
