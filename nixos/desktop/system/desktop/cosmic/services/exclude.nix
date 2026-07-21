{
  config,
  pkgs,
  lib,
  ...
}: {
  options.system.desktop.cosmic.services.exclude.enable = lib.mkEnableOption "Enable Gnome Extensions";

  config = lib.mkIf config.system.desktop.cosmic.services.exclude.enable {
    environment.cosmic.excludePackages = with pkgs; [
      cosmic-edit
      cosmic-term
    ];
  };
}
