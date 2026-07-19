{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.app.messaging.signal.enable = lib.mkEnableOption "Enable Signal Desktop App";

  config = lib.mkIf config.app.messaging.signal.enable {
    home.packages = with pkgs; [
      signal-desktop
    ];
  };
}
