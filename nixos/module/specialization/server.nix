{
  lib,
  config,
  ...
}:
{
  options.system.specialization.server = {
    enable = lib.mkEnableOption "Enable server specialization (SSH + Overleaf only, no GUI)";
  };

  config = lib.mkIf config.system.specialization.server.enable {
    specialisation.server = {
      configuration = {

        # Minimal networking
        networking.hostName = config.networking.hostName;
        networking.networkmanager.enable = lib.mkForce false;
        networking.firewall = lib.mkForce {
          enable = true;
          allowedTCPPorts = [ 22 ];
        };

        # SSH
        services.openssh.enable = lib.mkForce true;
        services.getty.autologinUser = "sia";
        services.getty.autologinOnce = true;

        # Overleaf
        services.overleaf = {
          enable = lib.mkForce true;
          port = 8080;
        };

        # Disable all desktop environments
        system.desktop.gnome.enable = lib.mkForce false;
        system.desktop.kdePlasma.enable = lib.mkForce false;
        system.desktop.cosmic.enable = lib.mkForce false;
        system.desktop.niri.enable = lib.mkForce false;

        # Disable non-essential services
        services.pipewire.enable = lib.mkForce false;
        services.upower.enable = lib.mkForce false;
        services.power-profiles-daemon.enable = lib.mkForce false;
        hardware.bluetooth.enable = lib.mkForce false;
        services.flatpak.enable = lib.mkForce false;

        # Minimal boot
        boot.loader.systemd-boot.enable = lib.mkForce true;
        boot.loader.efi.canTouchEfiVariables = lib.mkForce true;
        services.logind.lidSwitchExternalPower = "ignore";

        # Nix settings
        nixpkgs.config.allowUnfree = lib.mkForce true;

        # State version
        system.stateVersion = config.system.stateVersion;
      };
    };
  };
}
