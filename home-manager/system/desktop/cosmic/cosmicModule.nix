{ config, lib, ... }:
{
  imports = [
    ./custom/keymaps.nix
  ];

  options.system.desktop.cosmic.enable = lib.mkEnableOption "Enable COSMIC desktop customization";

  # When the parent COSMIC flag is off, force all sub-module options to
  # false so they cannot be toggled independently. When the parent is on,
  # sub-modules are freely toggleable.
  config = lib.mkIf (!config.system.desktop.cosmic.enable) {
    system.desktop.cosmic.custom = {
      keymaps.enable = lib.mkForce false;
    };
  };
}
