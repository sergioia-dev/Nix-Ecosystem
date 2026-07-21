{
  pkgs,
  lib,
  config,
  ...
}: {
  options.database.postgresql.enable = lib.mkEnableOption "Enables PostgreSQL";

  config = lib.mkIf config.database.postgresql.enable {
    services.postgresql = {
      enable = true;
      ensureDatabases = ["nixdocs"];
      initialScript = pkgs.writeText "create-public-user" ''
        CREATE USER k1 WITH PASSWORD '2110';
        GRANT ALL PRIVILEGES ON DATABASE nixdocs TO k1;
      '';
    };
  };
}
