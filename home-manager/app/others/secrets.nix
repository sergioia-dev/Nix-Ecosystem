{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.app.other.secrets; # shorthand for option path
in
{
  options.app.other.secrets = {
    enable = lib.mkEnableOption "Secrets a Account vault built for Gnome";
  };
  # ----- Configuration -----
  config = lib.mkIf cfg.enable {
    # Install the package
    home.packages = [ pkgs.gnome-secrets ];

  };
}
