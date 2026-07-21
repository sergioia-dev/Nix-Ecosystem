{
  pkgs,
  lib,
  config,
  ...
}: {
  options.system.shell.zsh.enable = lib.mkEnableOption "Enables zsh and its configuration";

  config = lib.mkIf config.system.shell.zsh.enable {
    programs.zsh = {
      enable = true;
    };

    users.extraUsers.k1 = {
      shell = pkgs.zsh;
    };
  };
}
