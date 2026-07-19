{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.app.messaging.telegram.enable = lib.mkEnableOption "Enable Telegram";

  config = lib.mkIf config.app.messaging.telegram.enable {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}
