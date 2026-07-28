{
  pkgs,
  lib,
  config,
  ...
}: {
  options.database.mysql.enable = lib.mkEnableOption "Enables MySQL";

  config = lib.mkIf config.database.mysql.enable {
    services = {
      mysql = {
        enable = true;
        package = pkgs.mariadb;
      };
    };
  };
}
