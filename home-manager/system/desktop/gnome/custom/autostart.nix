{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.system.desktop.gnome.custom.autostart.enable = lib.mkEnableOption "Enable Gnome Extensions";

  config = lib.mkIf config.system.desktop.gnome.custom.autostart.enable {
    home.file = lib.mkMerge [
      (lib.mkIf config.app.other.tangram.enable {
        ".config/autostart/tangram.desktop".text = ''
          [Desktop Entry]
          Version=1.0
          Terminal=false
          Type=Application
          Name=Tangram
          Exec=re.sonny.Tangram
        '';
      })
      {
        ".config/autostart/geary.desktop".text = ''
          [Desktop Entry]
          Version=1.0
          Terminal=false
          Type=Application
          Name=Geary Service
          Exec=geary --gapplication-service
          Hidden=true
          NoDisplay=true
          X-GNOME-Autostart-enabled=true
        '';
      }
    ];
  };
}
