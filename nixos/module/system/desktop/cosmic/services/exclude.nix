{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.system.desktop.cosmic.services.exclude.enable =
    lib.mkEnableOption "Exclude default Cosmic packages";

  config = lib.mkIf config.system.desktop.cosmic.services.exclude.enable {
    environment.cosmic.excludePackages = with pkgs; [
      cosmic-edit
    ];
  };
}
