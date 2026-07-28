{ inputs, ... }:
{
  imports = [
    ./system/systemBundle.nix
    ./database/databaseBundle.nix
    ./tool/toolBundle.nix
    ../hardware-configuration.nix
    inputs.overleaf.nixosModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.flatpak.enable = false;

  nix.settings = {
    download-buffer-size = 524288000;
    substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];
  };

  system = {
    desktop = {
      cosmic.enable = false;
      gnome.enable = true;
      kdePlasma.enable = false;
    };

    shell = {
      zsh.enable = true;
    };

    profile = {
      battery = {
        setBatteryLimit.enable = false;
      };
    };
  };

  database = {
    mysql.enable = false;
    sqlite.enable = false;
    postgresql.enable = false;
  };

  tool = {
    podman.enable = false;
    tomcat.enable = false;
    docker.enable = false;
    nginx.enable = false;
    virtManager.enable = false;
    steam.enable = false;
    waydroid.enable = false;
    openssh.enable = true;
    overleaf.enable = false;
  };

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
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Select internationalisation properties.
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

  # Configure console keymap
  console.keyMap = "us";

  # Enable sound with pipewire.
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

  system.stateVersion = "26.05"; # Did you read the comment?
}
