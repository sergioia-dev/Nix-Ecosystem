{ config, lib, inputs, ... }:

{
  imports = [
    inputs.cosmic-manager.homeManagerModules.default
    ./custom/appearance.nix
    ./custom/compositor.nix
    ./custom/wallpapers.nix
    ./custom/panels.nix
    ./custom/shortcuts.nix
  ];

  options.system.desktop.cosmic.enable =
    lib.mkEnableOption "Enable COSMIC desktop customization via home-manager";

  config = {
    # Always enable the underlying cosmic-manager module so it provides
    # cosmicLib via _module.args for the sub-modules.
    wayland.desktopManager.cosmic.enable = true;

    # When the parent COSMIC flag is off, force all sub-module options to
    # false so they cannot be toggled independently.
    system.desktop.cosmic = lib.mkIf (!config.system.desktop.cosmic.enable) {
      custom = {
        appearance.enable = lib.mkForce false;
        compositor.enable = lib.mkForce false;
        wallpapers.enable = lib.mkForce false;
        panels.enable = lib.mkForce false;
        shortcuts.enable = lib.mkForce false;
      };
    };
  };
}