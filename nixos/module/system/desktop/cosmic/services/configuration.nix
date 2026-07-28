{
  config,
  lib,
  ...
}: {
  options.system.desktop.cosmic.services.configuration.enable = lib.mkEnableOption "Enable Gnome Extensions";

  config = lib.mkIf config.system.desktop.cosmic.services.configuration.enable {
    services.displayManager.cosmic-greeter.enable = true;

    services.desktopManager.cosmic.enable = true;
    services.system76-scheduler.enable = true;
  };
}
