{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.system.desktop.niri.services.configuration.enable =
    lib.mkEnableOption "Enable Niri session (greetd, waybar, etc.)";

  config = lib.mkIf config.system.desktop.niri.services.configuration.enable {

    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];

    programs.niri.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = "sia";
        };
      };
    };
  };
}
