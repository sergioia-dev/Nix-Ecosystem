{
  lib,
  config,
  ...
}:
{
  options.tool.openssh.enable = lib.mkEnableOption "Enables Open SSH";
  config = lib.mkIf config.tool.openssh.enable {
    services.openssh = {
      enable = true;
      ports = [ 2222 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "sia" ];
      };
    };

    # Open ports in the firewall.
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        2222
      ];
    };
  };
}
