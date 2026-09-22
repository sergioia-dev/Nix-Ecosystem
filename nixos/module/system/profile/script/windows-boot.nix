# Scheduled EFI one-shot boot + reboot — desktop-agnostic NixOS module.
#
# Options (under `system.profile.boot.scheduleEfiReboot`):
#   enable     = true;              # root oneshot + daily timer (default: false)
#   bootEntry  = "0001";            # Boot#### entry passed to `efibootmgr -n`
#   time       = "*-*-* 07:00:00";  # systemd OnCalendar expression
#   persistent = true;              # catch up if missed while powered off
#
# Usage:
#   sudo efi-reboot                 # one-off: sets BootNext + reboots NOW
#   systemctl list-timers efi-reboot.timer
#   systemctl status efi-reboot.service
#   journalctl -u efi-reboot.service
#
# Sets BootNext via `efibootmgr -n <entry>` and immediately reboots, so only
# the *next* boot targets the chosen entry — the permanent EFI boot order is
# left untouched. Running as a root systemd unit avoids sudo/polkit entirely,
# so it works under any desktop environment (imported by systemBundle.nix).
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
  cfg = config.system.profile.boot.scheduleEfiReboot;
in
{
  options.system.profile.boot.scheduleEfiReboot = {
    enable = mkEnableOption "scheduled EFI one-shot boot entry + reboot (efibootmgr -n + reboot)";

    bootEntry = mkOption {
      type = types.str;
      default = "0001";
      description = ''
        EFI boot entry number passed to `efibootmgr -n` (BootNext). Must be a
        4-digit hex value, e.g. `0001` or `000A`. Only the next boot is
        affected; the permanent boot order is left untouched.
      '';
    };

    time = mkOption {
      type = types.str;
      default = "*-*-* 05:00:00";
      description = ''
        systemd `OnCalendar` expression for the daily timer. Defaults to
        every day at 07:00:00.
      '';
    };

    persistent = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to run the task at boot if it was missed while the machine
        was powered off.
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = builtins.match "[0-9A-Fa-f]{4}" cfg.bootEntry != null;
        message = "system.profile.boot.scheduleEfiReboot.bootEntry must be a 4-digit hex EFI boot entry (e.g. \"0001\")";
      }
    ];

    # Manual tool: run `sudo efi-reboot [entry]` to trigger the switch on
    # demand. The timer below handles the daily case automatically.
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "efi-reboot" ''
        #!${pkgs.runtimeShell}
        set -eu
        entry="''${1:-${cfg.bootEntry}}"

        if ! [[ "$entry" =~ ^[0-9A-Fa-f]{4}$ ]]; then
          echo "Usage: efi-reboot [4-digit-hex-entry]" >&2
          echo "Example: efi-reboot 0001" >&2
          exit 1
        fi

        echo "Setting next boot to EFI entry $entry and rebooting..."
        ${pkgs.efibootmgr}/bin/efibootmgr -n "$entry"
        ${pkgs.systemd}/bin/reboot
      '')
    ];

    # Root oneshot that switches BootNext and reboots. Running as root means
    # efibootmgr and reboot can both act without sudo or polkit, so the module
    # works under any desktop environment (not only Niri). Paired with the
    # timer below so it fires every day at the configured time.
    systemd.services."efi-reboot" = {
      description = "Set next EFI boot entry to ${cfg.bootEntry} and reboot";
      serviceConfig = {
        Type = "oneshot";
        User = "root";
        ExecStart = "${pkgs.efibootmgr}/bin/efibootmgr -n ${cfg.bootEntry}";
        ExecStartPost = "${pkgs.systemd}/bin/reboot";
      };
      path = [ pkgs.efibootmgr ];
    };

    # Daily timer that activates the oneshot above. Lives in the shared
    # profile module (imported via systemBundle), so it is desktop-agnostic.
    systemd.timers."efi-reboot" = {
      description = "Daily timer for efi-reboot.service (${cfg.time})";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = cfg.time;
        Persistent = cfg.persistent;
        Unit = "efi-reboot.service";
      };
    };
  };
}
