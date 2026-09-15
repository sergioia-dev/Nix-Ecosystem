{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:

let
  cfg = config.app.other.overleaf; # shorthand for option path
in
{

  imports = [
    inputs.overleaf.homeManagerModules.default
  ];

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
