{
  config,
  lib,
  ...
}: {
  options.system.desktop.kdePlasma.enable = lib.mkEnableOption "Enable KDE Plasma ";

  config = lib.mkIf config.system.desktop.kdePlasma.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
