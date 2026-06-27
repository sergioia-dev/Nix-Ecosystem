{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.console.terminal.foot.enable = lib.mkEnableOption "Enables Foot and its configuration";

  config = lib.mkIf config.console.terminal.foot.enable {
    home.packages = with pkgs; [
      foot
    ];

    home.file.".config/foot".source = ../foot;

  };
}
