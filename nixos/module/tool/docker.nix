{
  lib,
  config,
  ...
}:
{
  options.tool.docker.enable = lib.mkEnableOption "Enables Docker and Docker Add-Ons.";
  config = lib.mkIf config.tool.docker.enable {
    virtualisation.docker.enable = true;
    users.users.sia = {
      isNormalUser = true;
      extraGroups = [ "docker" ];
    };
  };
}
