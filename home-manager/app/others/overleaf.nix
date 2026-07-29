{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.app.other.overleaf; # shorthand for option path
in
{
  options.app.other.overleaf = {
    enable = lib.mkEnableOption "Enable a local Overleaf Text Editor in the Web
    ";
  };
  # ----- Configuration -----
  config = lib.mkIf cfg.enable {
    services.overleaf = {
      enable = true;
      port = 8080;
      texlivePackages = with pkgs.texlive; [ combined.scheme-full ];
    };

  };
}
