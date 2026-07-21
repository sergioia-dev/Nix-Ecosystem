{
  pkgs,
  lib,
  config,
  ...
}: {
  options.database.sqlite.enable = lib.mkEnableOption "Enables SQLite";

  config = lib.mkIf config.database.sqlite.enable {
    environment.systemPackages = [
      pkgs.sqlite
    ];
  };
}
