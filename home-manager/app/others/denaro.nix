{
  pkgs-unstable,
  lib,
  config,
  ...
}:

let
  cfg = config.app.other.denaro; # shorthand for option path
in
{
  options.app.other.denaro = {
    enable = lib.mkEnableOption "Denaro a Finantial app built for Gnome, Looks like has been abandoned";
  };
  # ----- Configuration -----
  config = lib.mkIf cfg.enable {
    # Install the package
    home.packages = [ pkgs-unstable.denaro ];

  };
}
