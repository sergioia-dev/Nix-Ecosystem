{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  options.system.desktop.cosmic.services.configuration.enable =
    lib.mkEnableOption "Enable Cosmic greeter & session";

  config = lib.mkIf config.system.desktop.cosmic.services.configuration.enable {

    environment.systemPackages = [
      pkgs.cosmic-ext-calculator
      pkgs-unstable.cosmic-viewer
      pkgs.wl-clipboard
    ];

    services.displayManager.cosmic-greeter.enable = true;

    services.desktopManager.cosmic.enable = true;
    services.system76-scheduler.enable = true;
  };
}
