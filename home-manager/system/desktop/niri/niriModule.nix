{
  config,
  lib,
  ...
}:
{
  options.system.desktop.niri.enable = lib.mkEnableOption "Enable Niri desktop customization";
  options.system.desktop.niri.waybar.enable = lib.mkEnableOption "Enable Waybar for Niri";

  config = lib.mkMerge [
    # Guard: waybar can only be enabled when the niri module is enabled.
    (lib.mkIf (!config.system.desktop.niri.enable) {
      system.desktop.niri.waybar.enable = lib.mkForce false;
    })
    # Niri config — applied only when the niri module is enabled.
    (lib.mkIf config.system.desktop.niri.enable {
      home.file.".config/niri/config.kdl".source = ./config.kdl;
    })
    # Waybar config — applied only when waybar is enabled (which, via the
    # guard above, implies niri.enable is true).
    (lib.mkIf config.system.desktop.niri.waybar.enable {
      home.file.".config/waybar/config".source = ./waybar/config;
      home.file.".config/waybar/style.css".source = ./waybar/style.css;
    })
  ];
}
