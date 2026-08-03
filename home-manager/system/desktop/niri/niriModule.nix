{ config, lib, ... }:
{
  imports = [
    ./noctalia/noctalia.nix
  ];

  options.system.desktop.niri.enable = lib.mkEnableOption "Enable Niri desktop customization";

  # Source the Niri shell config when the desktop is enabled. Unlike GNOME
  # (which configures everything via dconf in child modules), Niri uses a
  # `config.kdl` file, so it is sourced here at the parent level. When the
  # parent Niri flag is off, force all sub-module options to false so they
  # cannot be toggled independently. When the parent is on, sub-modules are
  # freely toggleable (mirrors the GNOME/COSMIC modules).
  config = lib.mkMerge [
    (lib.mkIf config.system.desktop.niri.enable {
      home.file.".config/niri/config.kdl".source = ./config.kdl;
    })
    (lib.mkIf (!config.system.desktop.niri.enable) {
      system.desktop.niri.noctalia.enable = lib.mkForce false;
    })
  ];
}
