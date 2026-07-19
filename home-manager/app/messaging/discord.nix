{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.app.messaging.discord.enable = lib.mkEnableOption "Enable Discord Desktop App";

  config = lib.mkIf config.app.messaging.discord.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
