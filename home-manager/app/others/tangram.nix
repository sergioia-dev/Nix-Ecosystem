# tangram.nix – Home Manager module for Tangram web‑app browser
{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.app.other.tangram;
in
{
  # ----- Options -----
  options.app.other.tangram = {
    enable = lib.mkEnableOption ''
      Enable Tangram, a browser for web apps (WhatsApp, Discord, Teams, etc.)
    '';
    autostart = lib.mkEnableOption ''
      Autostart Tangram on GNOME login (via .desktop file)
    '';
  };

  # ----- Configuration -----
  config = lib.mkMerge [
    # Lock autostart to false when the app is disabled
    (lib.mkIf (!cfg.enable) {
      app.other.tangram.autostart = lib.mkForce false;
    })
    # Apply config when the app is enabled
    (lib.mkIf cfg.enable {
      # Install the package
      home.packages = [ pkgs.tangram ];

      # Write the autostart .desktop file only if autostart is enabled
      xdg.configFile."autostart/tangram.desktop" = lib.mkIf cfg.autostart {
        text = ''
          [Desktop Entry]
          Type=Application
          Name=Tangram
          Comment=Web apps browser
          Exec=re.sonny.Tangram
          Icon=tangram
          Terminal=false
          X-GNOME-Autostart-enabled=true
        '';
      };
    })
  ];
}
