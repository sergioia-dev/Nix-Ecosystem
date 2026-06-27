{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.app.infomatic.foliate.enable = lib.mkEnableOption "Enable Mendeley";

  config = lib.mkIf config.app.infomatic.foliate.enable {
    home.packages = with pkgs; [ foliate ];
  };
}
