{
  lib,
  config,
  ...
}: {
  options.tool.steam.enable = lib.mkEnableOption "Enables Steam";
  config = lib.mkIf config.tool.steam.enable {
    programs.steam.enable = true;
  };
}
