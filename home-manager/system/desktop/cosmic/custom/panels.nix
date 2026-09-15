{ config, lib, ... }:

{
  options.system.desktop.cosmic.custom.panels.enable =
    lib.mkEnableOption "Enable COSMIC panel customization";

  config = lib.mkIf (config.system.desktop.cosmic.enable && config.system.desktop.cosmic.custom.panels.enable) {
    wayland.desktopManager.cosmic.panels = [
      {
        anchor = config._module.args.cosmicLib.cosmic.mkRON "enum" "Top";
        anchor_gap = false;
        background = config._module.args.cosmicLib.cosmic.mkRON "enum" "Dark";
        expand_to_edges = true;
        margin = 0;
        name = "Panel";
        opacity = 0;
        output = config._module.args.cosmicLib.cosmic.mkRON "enum" {
          value = [
            "eDP-1"
          ];
          variant = "Name";
        };
        plugins_center = config._module.args.cosmicLib.cosmic.mkRON "optional" [
          "com.system76.CosmicAppletTime"
          "com.system76.CosmicAppletNotifications"
        ];
        plugins_wings = config._module.args.cosmicLib.cosmic.mkRON "optional" (
          config._module.args.cosmicLib.cosmic.mkRON "tuple" [
            [
              "com.system76.CosmicAppletWorkspaces"
            ]
            [
              "com.system76.CosmicAppletStatusArea"
              "com.system76.CosmicAppletTiling"
              "com.system76.CosmicAppletAudio"
              "com.system76.CosmicAppletNetwork"
              "com.system76.CosmicAppletBattery"
              "com.system76.CosmicAppletBluetooth"
              "com.system76.CosmicAppletPower"
            ]
          ]
        );
        size = config._module.args.cosmicLib.cosmic.mkRON "enum" "XS";
      }
    ];
  };
}