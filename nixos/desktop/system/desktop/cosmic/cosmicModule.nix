{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./services/configuration.nix
    ./services/exclude.nix
  ];

  options.system.desktop.cosmic.enable = lib.mkEnableOption "Enable Gnome Desktop Environment";

  config = lib.mkIf config.system.desktop.cosmic.enable {
    environment.systemPackages = with pkgs; [
      foot
      gnome-calendar
      gnome-online-accounts-gtk
    ];

    system.desktop.cosmic = {
      services = {
        configuration.enable = true;
        exclude.enable = true;
      };
    };
  };
}
