{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.app.messaging.element.enable =
    lib.mkEnableOption "Enable Element Desktop App a Matrix Client";

  config = lib.mkIf config.app.messaging.element.enable {
    home.packages = with pkgs; [
      element-desktop
    ];
  };
}
