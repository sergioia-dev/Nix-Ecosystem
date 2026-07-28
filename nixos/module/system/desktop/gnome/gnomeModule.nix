{
  config,
  lib,
  ...
}: {
  imports = [
    ./services/exclude.nix
    ./services/configuration.nix
  ];
  options.system.desktop.gnome.enable = lib.mkEnableOption "Enable Gnome Desktop Environment";

  config = lib.mkIf config.system.desktop.gnome.enable {
    system.desktop.gnome = {
      services = {
        configuration.enable = true;
        exclude.enable = true;
      };
    };
    networking.firewall.allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    networking.firewall.allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
