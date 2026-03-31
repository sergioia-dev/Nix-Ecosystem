{
  lib,
  config,
  ...
}: {
  options.tool.podman.enable = lib.mkEnableOption "Enables Podman and Podman Add-Ons.";
  config = lib.mkIf config.tool.podman.enable {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      };
    };

    users.users.k1.extraGroups = ["podman"];
  };
}
