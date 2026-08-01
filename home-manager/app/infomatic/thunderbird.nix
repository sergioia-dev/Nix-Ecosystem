{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.app.infomatic.thunderbird.enable =
    lib.mkEnableOption "Enable ThunderBird Email, Calendar and Contacts";

  config = lib.mkIf config.app.infomatic.thunderbird.enable {
    home.packages = with pkgs; [ thunderbird ];
  };
}
