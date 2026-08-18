{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.system.desktop.niri.services.configuration.enable =
    lib.mkEnableOption "Enable Niri session (greetd, etc.)";

  config = lib.mkIf config.system.desktop.niri.services.configuration.enable {

    environment.systemPackages = with pkgs; [
      wl-clipboard
      xwayland-satellite
      nautilus
      tuigreet
    ];

    programs.niri.enable = true;
    services.gvfs.enable = true;

    environment.sessionVariables = {
      DISPLAY = ":1";
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
          user = "greeter";
        };
      };
    };
  };
}
