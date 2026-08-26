{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.app.other.localsend; # shorthand for option path
in
{
  options.app.other.localsend = {
    enable = lib.mkEnableOption "LocalSend Share files in your local red";
  };
  # ----- Configuration -----
  config = lib.mkIf cfg.enable {
    # Install the package
    home.packages = [ pkgs.localsend ];

  };
}
