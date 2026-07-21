{
  config,
  pkgs,
  lib,
  ...
}: {
  options.system.profile.battery.setBatteryLimit.enable = lib.mkEnableOption "Enable battery charge limit script";

  config = lib.mkIf config.system.profile.battery.setBatteryLimit.enable {
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "set-battery-limit" ''
        threshold="$1"

        if [ -z "$threshold" ]; then
          echo "Usage: set-battery-limit <percentage>"
          echo "Example: set-battery-limit 60"
          exit 1
        fi

        if ! [[ "$threshold" =~ ^[0-9]+$ ]] || [ "$threshold" -lt 1 ] || [ "$threshold" -gt 90 ]; then
          echo "Error: Provide a valid integer between 1-90"
          exit 1
        fi

        sudo sh -c "echo $threshold > /sys/class/power_supply/BAT0/charge_control_end_threshold"
        echo "Battery charge limit set to $threshold%"
      '')
    ];
  };
}
