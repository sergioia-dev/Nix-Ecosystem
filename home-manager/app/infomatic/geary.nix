{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.app.infomatic.geary.enable = lib.mkEnableOption "Enable Geary an email service";

  config = lib.mkIf config.app.infomatic.geary.enable {
    home.packages = with pkgs; [ geary ];
    systemd.user.services.geary = {
      Unit = {
        Description = "Geary Mail Client Service";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.geary}/bin/geary --gapplication-service";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };

  };
}
