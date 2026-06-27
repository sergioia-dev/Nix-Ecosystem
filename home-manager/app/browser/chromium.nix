{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.app.browser.chromium.enable = lib.mkEnableOption "Enable Firefox browser";

  config = lib.mkIf config.app.browser.chromium.enable {
    home.packages = with pkgs; [
      chromium
    ];
  };
}
