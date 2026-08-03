{ inputs, pkgs, ... }:
{
  imports = [
    ../module/moduleBundle.nix
    inputs.overleaf.nixosModules.default
  ];

  nixpkgs.config.allowUnfree = true;
  nix.registry.nixpkgs-unstable.flake = inputs.nixpkgs-unstable;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    download-buffer-size = 524288000;
    substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];
  };

  fonts.packages = with pkgs; [ jetbrains-mono ];

  services.flatpak.enable = false;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    upower.enable = true;
    power-profiles-daemon.enable = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Bogota";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT = "es_CO.UTF-8";
    LC_MONETARY = "es_CO.UTF-8";
    LC_NAME = "es_CO.UTF-8";
    LC_NUMERIC = "es_CO.UTF-8";
    LC_PAPER = "es_CO.UTF-8";
    LC_TELEPHONE = "es_CO.UTF-8";
    LC_TIME = "es_CO.UTF-8";
  };

  console.keyMap = "us";

  security.rtkit.enable = true;

  users.users.sia = {
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
    isNormalUser = true;
    description = "SIA";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "kvm"
    ];
  };

  system.stateVersion = "26.05";
}
