{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.app.infomatic.obs-studio.enable = lib.mkEnableOption "Enable OBS Studio";

  config = lib.mkIf config.app.infomatic.obs-studio.enable {
    home.packages = with pkgs; [
      obs-studio
    ];
  };
}
