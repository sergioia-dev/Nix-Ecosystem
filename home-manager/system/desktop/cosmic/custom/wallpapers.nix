{ config, lib, ... }:

{
  options.system.desktop.cosmic.custom.wallpapers.enable =
    lib.mkEnableOption "Enable COSMIC wallpaper customization";

  config = lib.mkIf (config.system.desktop.cosmic.enable && config.system.desktop.cosmic.custom.wallpapers.enable) {
    wayland.desktopManager.cosmic.wallpapers = [
      {
        filter_by_theme = true;
        filter_method = config._module.args.cosmicLib.cosmic.mkRON "enum" "Lanczos";
        output = "all";
        rotation_frequency = 600;
        sampling_method = config._module.args.cosmicLib.cosmic.mkRON "enum" "Alphanumeric";
        scaling_mode = config._module.args.cosmicLib.cosmic.mkRON "enum" "Stretch";
        source = config._module.args.cosmicLib.cosmic.mkRON "enum" {
          value = [
            ../../../../../assets/rose-pine-nix.webp
          ];
          variant = "Path";
        };
      }
    ];
  };
}