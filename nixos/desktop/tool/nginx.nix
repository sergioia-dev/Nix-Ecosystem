{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.tool.nginx.enable = lib.mkEnableOption "Enables Nginx.";
  config = lib.mkIf config.tool.nginx.enable {
    environment.systemPackages = with pkgs; [ nginx ];
    services.nginx = {
      enable = true;
      user = "sia";
      group = "users";
      # virtualHosts = {
      #   "example.test" = {
      #     addSSL = false;
      #     root = "/home/sia/Code/Projects/Nix-Docs";
      #   };
      # };
    };
    systemd.services.nginx.serviceConfig.ProtectHome = false;
  };
}
