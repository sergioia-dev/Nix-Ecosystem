{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.tool.waydroid.enable = lib.mkEnableOption "Enables Waydroid";
  config = lib.mkIf config.tool.waydroid.enable {
    virtualisation.waydroid.enable = true;
    virtualisation.waydroid.package = pkgs.waydroid-nftables;
  };
}
