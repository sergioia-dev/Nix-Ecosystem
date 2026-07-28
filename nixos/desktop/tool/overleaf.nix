{
  lib,
  config,
  ...
}:
{
  options.tool.overleaf.enable = lib.mkEnableOption "Enables Overleaf";
  config = lib.mkIf config.tool.overleaf.enable {
    services.overleaf = {
      enable = false;
      port = 8080;
      openFirewall = true;
    };
  };
}
