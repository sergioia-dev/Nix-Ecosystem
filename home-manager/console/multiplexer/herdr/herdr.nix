{
  pkgs-unstable,
  lib,
  config,
  ...
}:
{

  options.console.multiplexer.herdr.enable = lib.mkEnableOption "Nix language tooling";

  config = lib.mkIf config.console.multiplexer.herdr.enable {
    home.packages = with pkgs-unstable; [
      herdr
    ];

    home.file = {
      ".config/herdr/config.toml".source = ../../development/settings/configurations/herdr/config.toml;
    };
  };
}
