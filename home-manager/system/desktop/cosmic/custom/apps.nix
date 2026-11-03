{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.system.desktop.cosmic.custom.apps.enable =
    lib.mkEnableOption "Enable COSMIC shortcut customization";

  config =
    lib.mkIf (config.system.desktop.cosmic.enable && config.system.desktop.cosmic.custom.apps.enable)
      {
        programs.cosmic-term.settings = {
          # --- Appearance ---
          app_theme = "System"; # "Match desktop"
          syntax_theme_dark = "COSMIC Dark"; # "Color scheme dark"
          syntax_theme_light = "COSMIC Light"; # "Color scheme light"
          font_size_zoom_step_mul_100 = 100; # "Zoom steps" = 1px (100 * 0.01 = 1)
          opacity = 95; # "Background opacity" = 90%

          # --- Font ---
          font_name = "JetBrainsMono Nerd Font Mono"; # "Font"
          font_size = 17; # "Font size" = 17px

          # --- Splits ---
          focus_follows_mouse = true; # "Typing focus follows mouse" (ON)

          # --- Advanced ---
          show_headerbar = false; # "Show header" (OFF)
          # The "New tabs and windows use current directory" toggle
          # is not a direct global setting in the current module version.
          # It is controlled per-profile via the `working_directory` option
          # (see note below).
        };
      };
}
