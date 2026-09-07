{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.development.tool.dbeaver.enable = lib.mkEnableOption "Enable Figma Designer";

  config = lib.mkIf config.development.tool.dbeaver.enable {
    home.packages = with pkgs; [
      dbeaver-bin
    ];
  };
}
