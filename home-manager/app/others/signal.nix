{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.app.other.signal.enable = lib.mkEnableOption "Enable Signal Desktop App";

  config = lib.mkIf config.app.other.signal.enable {
    home.packages = with pkgs; [
      signal-desktop
    ];
  };
}
