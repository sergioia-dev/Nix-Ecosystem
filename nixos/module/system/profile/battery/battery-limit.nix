# Battery charge-threshold control — desktop-agnostic NixOS module.
#
# Options (under `system.profile.battery.setBatteryLimit`):
#   enable        = true;        # root oneshot at boot + CLI (default: false)
#   autoApply     = true;        # apply at boot via multi-user.target (default: true)
#   threshold     = 80;          # 1-100 (default: 80, matches the noctalia plugin)
#   batteryDevice = "BAT0";      # /sys/class/power_supply/<device>
#
# Usage:
#   sudo battery-limit 60                       # one-off manual set
#   systemctl status battery-charge-threshold.service        # inspect boot service
#   cat  /sys/class/power_supply/BAT0/charge_control_end_threshold
#
# Applies via a root service that writes `charge_control_end_threshold` at boot,
# replacing the noctalia battery-threshold plugin's user-space udev/group
# approach — no per-user `battery_ctl` group, no `udevadm trigger`, no re-login.
# Reusable across any desktop environment (imported by systemBundle.nix).
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.system.profile.battery.setBatteryLimit;
in
{
  options.system.profile.battery.setBatteryLimit = {
    enable = mkEnableOption "battery charge threshold control (boot service + CLI tool)";

    threshold = mkOption {
      type = types.int;
      default = 60;
      description = ''
        Desired battery charge threshold (1-100), written to the battery's
        `charge_control_end_threshold` sysfs attribute. Defaults to 80,
        matching the noctalia battery-threshold plugin's default.
      '';
    };

    batteryDevice = mkOption {
      type = types.str;
      default = "BAT0";
      description = "Battery device name under `/sys/class/power_supply/` (e.g. `BAT0`).";
    };

    autoApply = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to apply the threshold automatically at boot via a root systemd service.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.threshold >= 1 && cfg.threshold <= 100;
        message = "system.profile.battery.setBatteryLimit.threshold must be between 1 and 100";
      }
    ];

    # Manual tool: run `sudo battery-limit <percentage>` to re-apply on
    # demand. The boot service below handles the common case automatically.
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "battery-limit" ''
        #!${pkgs.runtimeShell}
        set -eu
        threshold="$1"

        if [ -z "$threshold" ]; then
          echo "Usage: battery-limit <percentage>"
          echo "Example: battery-limit 60"
          exit 1
        fi

        if ! [[ "$threshold" =~ ^[0-9]+$ ]] || [ "$threshold" -lt 1 ] || [ "$threshold" -gt 100 ]; then
          echo "Error: Provide a valid integer between 1-100"
          exit 1
        fi

        FILE="/sys/class/power_supply/${cfg.batteryDevice}/charge_control_end_threshold"

        if [ ! -e "$FILE" ]; then
          echo "Error: $FILE not found (battery charge threshold may not be supported on this hardware)" >&2
          exit 1
        fi

        echo "$threshold" > "$FILE"
        echo "Battery charge limit set to $threshold%"
      '')
    ];

    # Root oneshot that applies the threshold at boot, replacing the noctalia
    # battery-threshold plugin's user-space udev/rules + `battery_ctl` group
    # approach. Running as root means no per-user group membership is required
    # and no `udevadm trigger` / logout is needed after boot. Because this lives
    # in the shared profile module (imported via systemBundle), it works under
    # any desktop environment, not only Niri.
    systemd.services."battery-charge-threshold" = mkIf cfg.autoApply {
      description = "Set battery charge threshold to ${toString cfg.threshold}%";
      wantedBy = [ "multi-user.target" ];
      after = [ "sysinit.target" ];
      script = ''
        FILE="/sys/class/power_supply/${cfg.batteryDevice}/charge_control_end_threshold"
        # The battery sysfs attribute may appear shortly after boot; wait for it.
        for _ in $(seq 1 30); do
          [ -e "$FILE" ] && break
          sleep 1
        done
        if [ -e "$FILE" ]; then
          echo "${toString cfg.threshold}" > "$FILE" 2>/dev/null || true
        else
          echo "battery-charge-threshold: $FILE not found (battery charge threshold may not be supported on this hardware)" >&2
        fi
      '';
      path = [ pkgs.coreutils ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
    };
  };
}
