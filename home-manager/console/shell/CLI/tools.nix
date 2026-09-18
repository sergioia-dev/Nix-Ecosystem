{
  pkgs,
  lib,
  config,
  ...
}:
let
  git-worktree-clone = pkgs.writeShellApplication {
    name = "git-worktree-clone"; # enables `git worktree-clone`
    runtimeInputs = with pkgs; [
      git
      gnused
      gnugrep
      coreutils
    ];
    text = ''
      usage() {
        cat <<'USAGE_EOF'
      Usage: git worktree-clone <repo-url> <folder-name> [branch]

      Set up <folder-name> as a git worktree root backed by a bare repo at
      <folder-name>/.bare, then create an initial worktree for [branch].
      [branch] defaults to the remote's default branch.

      Examples:
        git worktree-clone git@github.com:user/repo.git my-project
        git worktree-clone git@github.com:user/repo.git my-project main
      USAGE_EOF
      }

      if [ "$#" -ge 1 ]; then
        case "$1" in
          -h|--help) usage; exit 0 ;;
        esac
      fi

      if [ "$#" -lt 2 ]; then
        usage >&2
        exit 1
      fi

      REPO_URL="$1"
      FOLDER="$2"
      BRANCH="''${3:-}"

      if [ -e "$FOLDER" ]; then
        printf 'error: %s already exists\n' "$FOLDER" >&2
        exit 1
      fi

      mkdir -p "$FOLDER"
      cd "$FOLDER" || exit 1

      # 1. Bare repository (init + remote, not clone --bare,
      #    so refs/heads/* stays empty and origin/* is the single source of truth)
      git init --bare --quiet .bare

      # 2. Point the project root at the bare repo
      printf 'gitdir: ./.bare\n' > .git

      # 3. Remote + standard fetch refspec
      git remote add origin "$REPO_URL"
      git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
      git fetch --quiet --prune origin

      # Populate refs/remotes/origin/HEAD so we can detect the default branch
      git remote set-head origin --auto >/dev/null 2>&1 || true

      # 4. Determine default branch if none was passed
      if [ -z "$BRANCH" ]; then
        BRANCH="$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null \
                  | sed 's|^origin/||' || true)"
        if [ -z "$BRANCH" ]; then
          BRANCH="$(git for-each-ref --format='%(refname:short)' refs/remotes/origin/ \
                    | grep -v 'origin/HEAD' | head -n1 | sed 's|^origin/||' || true)"
        fi
      fi

      if [ -z "$BRANCH" ]; then
        printf 'error: could not determine a default branch; pass one explicitly\n' >&2
        exit 1
      fi

      # 5. First worktree — DWIM creates a local tracking branch from origin/<branch>
      git worktree add "$BRANCH" "$BRANCH"

      printf '\nDone. Project at: %s/\n' "$FOLDER"
      printf '  cd %s/%s\n\n' "$FOLDER" "$BRANCH"
      printf 'Add more worktrees with:\n'
      printf '  git worktree add <folder> <branch>\n'
    '';
  };
in
{
  options.console.shell.tools.enable = lib.mkEnableOption "Enable CLI-Tools terminal";

  config = lib.mkIf config.console.shell.tools.enable {
    home.packages = with pkgs; [
      git
      zip
      unzip
      unrar
      ripgrep
      eza
      fzf
      bat
      zoxide
      curl
      osc
      git-worktree-clone
    ];

    home.shellAliases = {
      unrar = "unrar x";
      cat = "bat --theme='Catppuccin Mocha' --color=always";
      fm = "xdg-open";
      ls = "eza --icons=auto --git";
      wtc = "git worktree-clone";
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.btop = {
      enable = true;
      settings = {
        color_theme = "monokai";
        theme_background = false;
        vim_keys = true;
        rounded_corners = true;
      };
    };
  };
}
