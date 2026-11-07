{
  lib,
  ...
}:

{
  imports = [
    ../../app/appBundle.nix
    ../../console/consoleBundle.nix
    ../../development/developmentBundle.nix
    ../../system/systemBundle.nix
  ];

  console = {
    terminal = {
      cosmic.enable = true;
    };

    multiplexer = {
      tmux.enable = true;
    };

    shell = {
      bash.enable = true;
      tools.enable = lib.mkDefault true;
    };
  };

  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "26.05";
  };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

}
