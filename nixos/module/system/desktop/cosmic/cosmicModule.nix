{
  lib,
  config,
  ...
}:
{
  imports = [
    ./services/configuration.nix
    ./services/exclude.nix
  ];

  options.system.desktop.cosmic.enable = lib.mkEnableOption "Enable Cosmic Desktop Environment";

  config = lib.mkMerge [
    # Guard: submodules can only be enabled when the cosmic module is enabled.
    (lib.mkIf (!config.system.desktop.cosmic.enable) {
      system.desktop.cosmic.services = {
        configuration.enable = lib.mkForce false;
        exclude.enable = lib.mkForce false;
      };
    })
    (lib.mkIf config.system.desktop.cosmic.enable {
      system.desktop.cosmic.services = {
        configuration.enable = true;
        exclude.enable = true;
      };
    })
  ];
}
