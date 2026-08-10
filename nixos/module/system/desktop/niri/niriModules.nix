{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./services/configuration.nix
  ];

  options.system.desktop.niri.enable = lib.mkEnableOption "Enable Niri Desktop Environment";

  # Machine-side install of the Noctalia shell. The shell is *configured*
  # per-user in Home Manager (home-manager/system/desktop/niri/noctalia);
  # here we only make the noctalia-shell package available system-wide,
  # mirroring the pattern niri itself uses (see services/configuration.nix).
  #
  # We deliberately do NOT enable the noctalia flake's `nixosModules.default`:
  # its only effect beyond this package install is the (legacy-v4)
  # `services.noctalia-shell` systemd integration, whose unit emits a
  # deprecation warning when enabled. The package install below is the
  # officially documented NixOS install path, and Home Manager takes care of
  # launching/configuration. See:
  # https://docs.noctalia.dev/noctalia/getting-started/nixos/#installing-the-package
  options.system.desktop.niri.noctalia.enable = lib.mkOption {
    type = lib.types.bool;
    default = config.system.desktop.niri.enable;
    defaultText = "config.system.desktop.niri.enable";
    description = "Whether to install the Noctalia shell package machine-wide (configuration stays per-user in Home Manager).";
  };

  config = lib.mkMerge [
    # Guard: submodules can only be enabled when the niri module is enabled.
    (lib.mkIf (!config.system.desktop.niri.enable) {
      system.desktop.niri.services.configuration.enable = lib.mkForce false;
      system.desktop.niri.noctalia.enable = lib.mkForce false;
    })
    (lib.mkIf config.system.desktop.niri.enable {
      system.desktop.niri.services.configuration.enable = true;
    })
    (lib.mkIf config.system.desktop.niri.noctalia.enable {
      environment.systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    })
  ];
}
