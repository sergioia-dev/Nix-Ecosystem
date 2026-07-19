{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.development.AI.opencode.enable = lib.mkEnableOption "Enable Opencode Client";

  config = lib.mkIf config.development.AI.opencode.enable {
    home.packages = with pkgs; [
      opencode
    ];

    home.file = {
      ".config/opencode/tui.json".source = ../settings/configurations/opencode/tui.json;
    };
  };
}
