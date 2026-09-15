{ config, lib, ... }:

{
  options.system.desktop.cosmic.custom.compositor.enable =
    lib.mkEnableOption "Enable COSMIC compositor customization";

  config =
    lib.mkIf
      (config.system.desktop.cosmic.enable && config.system.desktop.cosmic.custom.compositor.enable)
      {
        wayland.desktopManager.cosmic.compositor = {
          active_hint = true;
          autotile = true;
          autotile_behavior = config._module.args.cosmicLib.cosmic.mkRON "enum" "Global";
          cursor_follows_focus = false;
          descale_xwayland = false;
          edge_snap_threshold = 0;
          focus_follows_cursor = false;
          focus_follows_cursor_delay = 250;
          workspaces = {
            workspace_layout = config._module.args.cosmicLib.cosmic.mkRON "enum" "Vertical";
            workspace_mode = config._module.args.cosmicLib.cosmic.mkRON "enum" "OutputBound";
          };
          xkb_config = {
            layout = "us";
            model = "pc104";
            options = config._module.args.cosmicLib.cosmic.mkRON "optional" "compose:ralt,caps:escape";
            repeat_delay = 600;
            repeat_rate = 25;
            rules = "";
            variant = "";
          };
        };
      };
}
