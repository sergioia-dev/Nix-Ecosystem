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
      pkgs.cosmic-ext-applet-external-monitor-brightness
      pkgs.kooha
    ];
    # 1. Enable I2C hardware support
    hardware.i2c.enable = true;

    # 2. Force load kernel modules for external monitor communication
    boot.kernelModules = [
      "i2c-dev"
      "ddcci_backlight"
    ];
    boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];

    services.displayManager.cosmic-greeter.enable = true;

    services.desktopManager.cosmic.enable = true;
    services.system76-scheduler.enable = true;
  };
}
