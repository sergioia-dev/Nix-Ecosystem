{
  config,
  lib,
  ...
}:
{
  imports = [
    ./services/configuration.nix
  ];

  options.system.desktop.niri.enable = lib.mkEnableOption "Enable Niri Desktop Environment";

  config = lib.mkMerge [
    # Guard: submodules can only be enabled when the niri module is enabled.
    (lib.mkIf (!config.system.desktop.niri.enable) {
      system.desktop.niri.services.configuration.enable = lib.mkForce false;
    })
    (lib.mkIf config.system.desktop.niri.enable {
      system.desktop.niri.services.configuration.enable = true;
    })
  ];
}
