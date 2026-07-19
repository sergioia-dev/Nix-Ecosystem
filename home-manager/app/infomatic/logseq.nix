{
  pkgs,
  lib,
  config,
  ...
}:
let
  # Customise this to your repository path
  repoPath = "${config.home.homeDirectory}/Documents/notes/";

  # The script that checks and pushes
  autoPushScript = pkgs.writeShellScript "auto-push" ''
    set -euo pipefail

    LOGFILE="/tmp/auto-push.log"

    # Function to log with timestamp
    log() {
      echo "$(date '+%Y-%m-%d %H:%M:%S') - $*" | tee -a "$LOGFILE"
    }

    # Start logging
    log "=== Starting auto-push check ==="

    cd "${repoPath}" || {
      log "ERROR: Cannot change to ${repoPath}"
      exit 1
    }

    # Fetch remote state
    log "Fetching remote..."
    if ! git fetch --quiet 2>&1 | tee -a "$LOGFILE"; then
      log "ERROR: git fetch failed"
      exit 1
    fi

    # Determine upstream branch
    upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || true)
    if [[ -z "$upstream" ]]; then
      log "No upstream branch set – skipping push."
      log "=== Finished (no upstream) ==="
      exit 0
    fi

    # Count unpushed commits
    ahead=$(git rev-list --count "$upstream..HEAD" 2>/dev/null || echo 0)
    if [[ "$ahead" -eq 0 ]]; then
      log "No unpushed commits."
      log "=== Finished (up to date) ==="
      exit 0
    fi

    log "Pushing $ahead unpushed commit(s)..."
    if git push 2>&1 | tee -a "$LOGFILE"; then
      log "Push successful."
    else
      log "ERROR: Push failed."
      exit 1
    fi

    log "=== Finished (push done) ==="
  '';

in
{
  options.app.infomatic.logseq.enable = lib.mkEnableOption "Enable Logseq";

  config = lib.mkIf config.app.infomatic.logseq.enable {
    nixpkgs.config.permittedInsecurePackages = [
      "electron-39.8.10"
    ];
    home.packages = with pkgs; [ logseq ];
    systemd.user = {
      services.auto-push = {
        Unit = {
          Description = "Push unpushed git commits automatically";
          # Run after network is up (user session)
          After = [ "network.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${autoPushScript}";
          # Environment for git – you may need to set GIT_SSH or similar
          # if you use a custom SSH key.
          # Environment = [ "GIT_SSH_COMMAND=ssh -i /path/to/key" ];
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };

      timers.auto-push = {
        Unit = {
          Description = "Timer for auto-push service";
        };
        Timer = {
          # Run every hour
          OnCalendar = "hourly";
          Persistent = true; # run immediately if missed while off
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
