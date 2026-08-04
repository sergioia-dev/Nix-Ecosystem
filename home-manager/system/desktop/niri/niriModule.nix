{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./noctalia/noctalia.nix
    ./custom/outputs.nix
    ./custom/binds.nix
    ./custom/input.nix
    ./custom/layout.nix
    ./custom/spawn.nix
    ./custom/others.nix
  ];

  options.system.desktop.niri.enable = lib.mkEnableOption "Enable Niri desktop customization";

  config = lib.mkMerge [
    # When niri is enabled, activate the desktop engine.
    (lib.mkIf config.system.desktop.niri.enable {
      programs.niri.enable = true;
      # Validate against niri-unstable, which the bind settings target.
      programs.niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
    })
    # When the parent niri flag is off, force all sub-module options to
    # false so they cannot be toggled independently.
    (lib.mkIf (!config.system.desktop.niri.enable) {
      system.desktop.niri = {
        noctalia = {
          enable = lib.mkForce false;
        };
        custom = {
          outputs = {
            enable = lib.mkForce false;
          };
          binds = {
            enable = lib.mkForce false;
          };
          input = {
            enable = lib.mkForce false;
          };
          layout = {
            enable = lib.mkForce false;
          };
          spawn = {
            enable = lib.mkForce false;
          };
          others = {
            enable = lib.mkForce false;
          };
        };
      };
    })
  ];
}
