{ config, lib, ... }:
{
  imports = [
    ./custom/extensions.nix
    ./custom/theme.nix
    ./custom/keymaps.nix
    ./apps/geary.nix
  ];

  options.system.desktop.gnome.enable = lib.mkEnableOption "Enable GNOME desktop customization";

  # When the parent GNOME flag is off, force all sub-module options to
  # false so they cannot be toggled independently. When the parent is on,
  # sub-modules are freely toggleable.
  config = lib.mkIf (!config.system.desktop.gnome.enable) {
    system.desktop.gnome = {
      custom = {
        extensions.enable = lib.mkForce false;
        theme.enable = lib.mkForce false;
        keymaps.enable = lib.mkForce false;
      };
      apps.geary = {
        enable = lib.mkForce false;
        autostart = lib.mkForce false;
      };
    };
  };
}
