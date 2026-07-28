{
  lib,
  config,
  ...
}:
{
  options.tool.openssh.enable = lib.mkEnableOption "Enables Open SSH";
  config = lib.mkIf config.tool.openssh.enable {
    services.openssh.enable = true;

    # Open ports in the firewall.
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];
    };
  };
}
