{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.app.browser.firefox.enable = lib.mkEnableOption "Enable Firefox browser";

  config = lib.mkIf config.app.browser.firefox.enable {

    home.packages = with pkgs; [ firefoxpwa ];

    programs = {
      firefox = {
        enable = true;
        package = pkgs.firefox;
        nativeMessagingHosts = with pkgs; [ firefoxpwa ];
      };
    };
  };
}
