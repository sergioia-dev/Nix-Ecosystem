{
  pkgs,
  lib,
  config,
  ...
}: {
  options.tool.tomcat.enable = lib.mkEnableOption "Enables Tomcat Server";
  config = lib.mkIf config.tool.tomcat.enable {
    services.tomcat = {
      enable = false;
    };
  };
}
