{
  pkgs,
  lib,
  config,
  ...
}: {
  options.app.infomatic.affine.enable = lib.mkEnableOption "Enable Mendeley";

  config = lib.mkIf config.app.infomatic.affine.enable {
    home.packages = with pkgs; [affine];
  };
}
