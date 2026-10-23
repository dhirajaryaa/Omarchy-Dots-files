#!/usr/bin/env bash
# Omarchy dotfiles backup
# Creates a timestamped, checksummed backup of personal Omarchy/desktop config.
# Read-only with respect to the source configuration.

set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
HOME_DIR=${HOME:?HOME is not set}
DEFAULT_BASE="$HOME_DIR/Backups/omarchy-dotfiles"
OUTPUT=""
NO_WALLPAPERS=0
QUIET=0

die() { printf 'error: %s\n' "$*" >&2; exit 1; }
log() { [ "$QUIET" -eq 1 ] || printf '%s\n' "$*"; }
warn() { printf 'warning: %s\n' "$*" >&2; }

usage() {
  cat <<'EOF'
Usage: backup.sh [options]

Create a timestamped backup of personal Omarchy desktop configuration.

Options:
  --output DIR       Write to DIR. It must not exist or must be empty.
                     Default: ~/Backups/omarchy-dotfiles/YYYY-MM-DD_HHMMSS
  --no-wallpapers    Skip wallpaper/background image trees (saves ~100 MB).
  --quiet            Only print warnings and errors.
  -h, --help         Show this help.

The backup is written outside ~/.config. Source files are only read.
EOF
}

while (($#)); do
  case "$1" in
    --output)
      (($# >= 2)) || die "--output needs a directory"
      OUTPUT=$2
      shift 2
      ;;
    --no-wallpapers) NO_WALLPAPERS=1; shift ;;
    --quiet) QUIET=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "unknown option: $1 (try --help)" ;;
  esac
done

command -v rsync >/dev/null 2>&1 || die "rsync is required but not installed"

if [ -z "$OUTPUT" ]; then
  mkdir -p -- "$DEFAULT_BASE"
  OUTPUT="$DEFAULT_BASE/$(date +%Y-%m-%d_%H%M%S)"
fi

if [ -e "$OUTPUT" ] && [ ! -d "$OUTPUT" ]; then
  die "output exists and is not a directory: $OUTPUT"
fi
if [ -d "$OUTPUT" ] && [ -n "$(ls -A -- "$OUTPUT" 2>/dev/null)" ]; then
  die "refusing to write into a non-empty directory: $OUTPUT"
fi

mkdir -p -- "$OUTPUT"
OUTPUT=$(cd -- "$OUTPUT" && pwd)
[ "$OUTPUT" != "$HOME_DIR" ] || die "refusing to use \$HOME as the backup directory"

case "$OUTPUT/" in
  "$HOME_DIR/.config/"*) die "refusing to put a backup inside ~/.config" ;;
esac

TMPDIR_RUN=$(mktemp -d "${TMPDIR:-/tmp}/omarchy-backup.XXXXXX")
trap 'rm -rf -- "$TMPDIR_RUN"' EXIT
SOURCES_FILE="$TMPDIR_RUN/sources.tsv"
SKIPPED_FILE="$TMPDIR_RUN/skipped.tsv"
: >"$SOURCES_FILE"
: >"$SKIPPED_FILE"

record_source() { printf '%s\t%s\n' "$1" "$2" >>"$SOURCES_FILE"; }
record_missing() { printf '%s\tmissing source\n' "$1" >>"$SKIPPED_FILE"; }

copy_tree() {
  local src=$1 dest=$2
  shift 2
  if [ ! -d "$src" ]; then
    warn "missing directory, skipped: $src"
    record_missing "$src"
    return 0
  fi
  mkdir -p -- "$OUTPUT/$dest"
  local -a excludes=()
  local pattern
  for pattern in "$@"; do
    [ -n "$pattern" ] && excludes+=(--exclude="$pattern")
  done
  rsync -a "${excludes[@]}" -- "$src/" "$OUTPUT/$dest/"
  record_source "$src" "$dest"
  log "backed up: $src -> $dest"
}

copy_file() {
  local src=$1 dest=$2
  if [ ! -e "$src" ] && [ ! -L "$src" ]; then
    warn "missing file, skipped: $src"
    record_missing "$src"
    return 0
  fi
  mkdir -p -- "$OUTPUT/$(dirname -- "$dest")"
  rsync -a -- "$src" "$OUTPUT/$dest"
  record_source "$src" "$dest"
  log "backed up: $src -> $dest"
}

# ---------------------------------------------------------------------------
# Payload
# ---------------------------------------------------------------------------

# Hyprland. Omarchy 4.x uses Lua config files, not hyprland.conf.
copy_tree "$HOME_DIR/.config/hypr" "config/hypr" "*.lacquer-backup-*"

# Omarchy shell / Quickshell configuration.
copy_file "$HOME_DIR/.config/omarchy/shell.json" "config/omarchy/shell.json"
copy_file "$HOME_DIR/.config/omarchy/shell.toml" "config/omarchy/shell.toml"
copy_tree "$HOME_DIR/.config/omarchy/extensions" "config/omarchy/extensions"
copy_file "$HOME_DIR/.config/omarchy/hooks/theme-set.d/omazed" \
  "config/omarchy/hooks/theme-set.d/omazed"

# User themes. Exclude the theme checkout's .git pack (provenance is recorded).
wallpaper_excludes=()
[ "$NO_WALLPAPERS" -eq 1 ] && wallpaper_excludes=("backgrounds/")
copy_tree "$HOME_DIR/.config/omarchy/themes/aether" "config/omarchy/themes/aether" \
  ".git/" "*.lacquer-backup-*" "${wallpaper_excludes[@]}"
copy_tree "$HOME_DIR/.config/omarchy/themes/snow_black" "config/omarchy/themes/snow_black" \
  ".git/" "*.lacquer-backup-*" "${wallpaper_excludes[@]}"

# Third-party Quickshell plugin. Keep files; record .git provenance separately.
copy_tree "$HOME_DIR/.config/omarchy/plugins/stappmus.activity-monitor" \
  "config/omarchy/plugins/stappmus.activity-monitor" ".git/" "*.lacquer-backup-*"

# Do not back up the plugin's privilege-escalation rule.
rm -f -- "$OUTPUT/config/omarchy/plugins/stappmus.activity-monitor/stappmus-activity-monitor.sudoers"

# Custom wallpapers.
if [ "$NO_WALLPAPERS" -eq 0 ]; then
  copy_tree "$HOME_DIR/.config/omarchy/backgrounds/solitude" \
    "config/omarchy/backgrounds/solitude"
else
  log "skipping wallpapers (--no-wallpapers)"
fi

copy_tree "$HOME_DIR/.config/omarchy/branding" "config/omarchy/branding"

# ---------------------------------------------------------------------------
# Scope: only ~/.config/hypr and ~/.config/omarchy are backed up.
# All other application configs are excluded by request.
# ---------------------------------------------------------------------------


# Files outside ~/.config are intentionally NOT copied.
# Per user request, personal home-directory files (.bashrc, .bash_profile,
# .XCompose, .fonts, .local/bin, documents, etc.) stay out of this backup.
warn "home-directory files are excluded by request; only ~/.config is backed up"

# ---------------------------------------------------------------------------
# Manifest: system/version, packages, provenance
# ---------------------------------------------------------------------------

mkdir -p -- "$OUTPUT/manifest" "$OUTPUT/packages"

{
  printf 'snapshot_date=%s\n' "$(date -Is)"
  printf 'hostname=%s\n' "$(hostname 2>/dev/null || true)"
  printf 'user=%s\n' "${USER:-}"
  printf 'home=%s\n' "$HOME_DIR"
  printf 'kernel=%s\n' "$(uname -r)"
  printf 'omarchy_version=%s\n' "$(omarchy version 2>/dev/null || cat /usr/share/omarchy/version 2>/dev/null || echo unknown)"
  printf 'omarchy_package=%s\n' "$(pacman -Q omarchy 2>/dev/null || echo unknown)"
  printf 'omarchy_path=%s\n' "${OMARCHY_PATH:-/usr/share/omarchy}"
  printf 'os_release=%s\n' "$(sed -n 's/^PRETTY_NAME=//p' /etc/os-release 2>/dev/null | tr -d '\"')"
  printf 'hyprland=%s\n' "$(pacman -Q hyprland 2>/dev/null || echo unknown)"
  printf 'quickshell=%s\n' "$(pacman -Q quickshell 2>/dev/null || echo unknown)"
  printf 'current_theme=%s\n' "$(cat "$HOME_DIR/.local/state/omarchy/current/theme.name" 2>/dev/null || echo unknown)"
  printf 'current_background=%s\n' "$(readlink -f "$HOME_DIR/.local/state/omarchy/current/background" 2>/dev/null || echo unknown)"
  printf 'wallpapers_included=%s\n' "$([ "$NO_WALLPAPERS" -eq 0 ] && echo yes || echo no)"
} >"$OUTPUT/manifest/system.txt"

{
  printf 'path\tremote\tbranch\tcommit\tdirty_files\n'
  for repo in \
    "$HOME_DIR/.config/omarchy/themes/snow_black" \
    "$HOME_DIR/.config/omarchy/plugins/stappmus.activity-monitor"; do
    if git -C "$repo" rev-parse --git-dir >/dev/null 2>&1; then
      remote=$(git -C "$repo" remote get-url origin 2>/dev/null | sed -E 's#(https?://)[^/@]+@#\1#' || true)
      branch=$(git -C "$repo" branch --show-current 2>/dev/null || true)
      commit=$(git -C "$repo" rev-parse HEAD 2>/dev/null || true)
      dirty=$(git -C "$repo" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
      printf '%s\t%s\t%s\t%s\t%s\n' "$repo" "$remote" "$branch" "$commit" "$dirty"
    fi
  done
} >"$OUTPUT/manifest/git-repos.tsv"

{
  printf 'package\tversion\n'
  for pkg in omarchy hyprland quickshell foot alacritty kitty ghostty cava btop \
    starship tmux neovim git aether stow; do
    p=$(pacman -Q "$pkg" 2>/dev/null || true)
    [ -n "$p" ] && printf '%s\n' "$p" | tr ' ' '\t'
  done
} >"$OUTPUT/packages/versions.txt"

if command -v pacman >/dev/null 2>&1; then
  pacman -Qe >"$OUTPUT/packages/pacman-explicit.txt" 2>/dev/null || true
  pacman -Qeq >"$OUTPUT/packages/pacman-explicit-names.txt" 2>/dev/null || true
  pacman -Qm >"$OUTPUT/packages/pacman-foreign.txt" 2>/dev/null || true
  pacman -Qmq >"$OUTPUT/packages/pacman-foreign-names.txt" 2>/dev/null || true
else
  printf 'pacman not available\n' >"$OUTPUT/packages/pacman-explicit.txt"
fi

if command -v mise >/dev/null 2>&1; then
  mise ls -g >"$OUTPUT/packages/mise-globals.txt" 2>/dev/null || true
fi
if command -v flatpak >/dev/null 2>&1; then
  flatpak list --columns=application,version >"$OUTPUT/packages/flatpak.txt" 2>/dev/null || true
else
  printf 'flatpak not installed\n' >"$OUTPUT/packages/flatpak.txt"
fi

cat >"$OUTPUT/packages/README.md" <<'EOF'
# Packages

These files record the package set of the source machine. They are not a full
system restore.

- `pacman-explicit.txt` — explicitly installed packages with versions.
- `pacman-explicit-names.txt` — names only, suitable for reinstall.
- `pacman-foreign.txt` / `pacman-foreign-names.txt` — AUR/foreign packages.

On a fresh Omarchy install, install only the packages that are missing:

```bash
comm -23 <(sort pacman-explicit-names.txt) <(pacman -Qq | sort) | sudo pacman -S --needed -
```

Then handle foreign packages (review first; some may now be in the repos):

```bash
comm -23 <(sort pacman-foreign-names.txt) <(pacman -Qq | sort)
# review the list, then:
yay -S --needed <package> ...
```

Do not blindly reinstall `base`, kernel, firmware, bootloader, or Omarchy
packages. Omarchy itself should be installed by its own installer.
EOF

# Keybindings: the live source of truth on this machine.
if command -v omarchy >/dev/null 2>&1; then
  if ! omarchy menu keybindings --print >"$OUTPUT/manifest/keybindings.txt" 2>"$TMPDIR_RUN/keybindings.err"; then
    {
      printf 'Could not read live keybindings.\n'
      cat "$TMPDIR_RUN/keybindings.err"
    } >"$OUTPUT/manifest/keybindings.txt"
  fi
else
  printf 'omarchy command not available\n' >"$OUTPUT/manifest/keybindings.txt"
fi

# Static exclusion documentation.
cat >"$OUTPUT/manifest/excluded.tsv" <<'EOF'
path_or_pattern	reason
~/.ssh/	Private SSH keys and known_hosts; never backed up.
~/.gnupg/, ~/.pki/	Private keys and certificate stores; never backed up.
~/.config/gh/, ~/.config/git/credentials	GitHub CLI auth and Git credential helpers; secrets.
~/.config/opencode/, ~/.config/Code/, ~/.config/Cursor/, ~/.config/Claude/	App state and possible API tokens; not Omarchy desktop config.
~/.config/BraveSoftware/, ~/.config/google-chrome*, ~/.config/chromium/	Browser profiles, cookies, sessions, passwords.
~/.config/obsidian/, ~/.config/obs-studio/, ~/.config/qBittorrent/	Application data; not desktop configuration.
~/.cache/, ~/.local/share/, ~/.local/state/	Caches, downloaded plugins, runtime/generated state.
~/.bashrc, ~/.bash_profile, ~/.XCompose	Personal home-directory files; excluded by request.
~/.fonts/, ~/.local/bin/	Personal home-directory files; excluded by request.
~/Documents/, ~/Downloads/, ~/Pictures/, ~/Videos/, ~/Music/	Personal documents and media; not dotfiles.
~/.bash_history	Shell history; may contain secrets.
*.lacquer-backup-*	Stale tool-generated backups; the live file is backed up.
*.bak.*, kitty.conf.bak.*	Stale local backups; the live file is backed up.
*.sample	Stock Omarchy example hooks/theme templates.
~/.config/omarchy/hooks/post-update.d/*.hook	Stock first-run hooks (verified identical to /usr/share/omarchy).
~/.config/omarchy/plugins/stappmus.activity-monitor/stappmus-activity-monitor.sudoers	Privilege-escalation rule; excluded as security-sensitive. Upstream provides it.
~/.config/omarchy/defaults/agent	AI-agent preference; excluded by request.
All non-Hyprland, non-Omarchy ~/.config directories	Terminal, editor, Git, AI, browser, app state, and other private configs; excluded by request.
~/.config/omarchy/themes/snow_black/.git/	93 MB git pack; upstream URL and commit are recorded instead.
~/.config/omarchy/plugins/stappmus.activity-monitor/.git/	Git pack; upstream URL and commit are recorded instead.
~/.config/omarchy/wattage/	Empty runtime directory.
~/.config/menus/applications-merged/*.menu	Generated by app installers.
~/.config/kitty/kitty.conf.bak.NoBkLs	Stale local backup.
/etc/, /boot/, /usr/share/omarchy/	System-managed files; owned by packages, not dotfiles.
EOF

# Symlinks in the payload (targets are recorded, restore recreates them).
{
  printf 'backup_path\ttarget\n'
  find "$OUTPUT/config" -type l -printf '%p\t%l\n' 2>/dev/null |
    sed "s#^$OUTPUT/##" | sort || true
} >"$OUTPUT/manifest/symlinks.tsv"

# Sources/skips.
{
  printf 'source\tbackup_path\n'
  sort "$SOURCES_FILE"
} >"$OUTPUT/manifest/sources.tsv"
{
  printf 'source\treason\n'
  sort "$SKIPPED_FILE"
} >"$OUTPUT/manifest/skipped.tsv"

# Security scan: report file names only, never matching values.
{
  printf 'Security scan of backed-up files (file names only; values are not printed)\n'
  printf 'Snapshot: %s\n\n' "$(date -Is)"
  pattern='(api[_-]?key|password|passwd|secret|bearer[[:space:]]|ghp_[A-Za-z0-9]{20,}|sk-[A-Za-z0-9]{20,}|xox[bap]-|AKIA[0-9A-Z]{16}|BEGIN [A-Z ]*PRIVATE KEY|token[[:space:]]*[=:])'
  matches=$(grep -rIlE "$pattern" "$OUTPUT/config" "$OUTPUT/packages" 2>/dev/null || true)
  if [ -n "$matches" ]; then
    printf 'Potential matches (review before publishing):\n%s\n' "$matches"
  else
    printf 'No likely secret patterns found in the backed-up files.\n'
  fi
} >"$OUTPUT/manifest/security-scan.txt"

# Detailed file manifest.
{
  printf 'type\tmode\tsize\tsha256\tsource\tbackup_path\tsymlink_target\n'
  while IFS=$'\t' read -r src dst; do
    [ -n "$dst" ] || continue
    abs="$OUTPUT/$dst"
    if [ -d "$abs" ]; then
      while IFS= read -r -d '' f; do
        rel=${f#"$abs"/}
        orig="$src/$rel"
        if [ -L "$f" ]; then
          printf 'l\t-\t0\t-\t%s\t%s\t%s\n' "$orig" "${f#"$OUTPUT/"}" "$(readlink "$f")"
        elif [ -f "$f" ]; then
          printf 'f\t%s\t%s\t%s\t%s\t%s\t-\n' \
            "$(stat -c %a "$f")" "$(stat -c %s "$f")" \
            "$(sha256sum "$f" | cut -d' ' -f1)" "$orig" "${f#"$OUTPUT/"}"
        fi
      done < <(find "$abs" \( -type f -o -type l \) -print0 | sort -z)
    elif [ -f "$abs" ] || [ -L "$abs" ]; then
      if [ -L "$abs" ]; then
        printf 'l\t-\t0\t-\t%s\t%s\t%s\n' "$src" "$dst" "$(readlink "$abs")"
      else
        printf 'f\t%s\t%s\t%s\t%s\t%s\t-\n' \
          "$(stat -c %a "$abs")" "$(stat -c %s "$abs")" \
          "$(sha256sum "$abs" | cut -d' ' -f1)" "$src" "$dst"
      fi
    fi
  done < <(sort "$SOURCES_FILE")
} >"$OUTPUT/manifest/files.tsv"

# Checksums cover the payload, not the manifest itself.
(
  cd -- "$OUTPUT"
  find config packages -type f -print0 2>/dev/null |
    sort -z |
    xargs -0 -r sha256sum >manifest/checksums.sha256
)

# Make the snapshot self-contained where possible.
mkdir -p -- "$OUTPUT/scripts"
for helper in backup.sh restore.sh verify.sh; do
  if [ -f "$SCRIPT_DIR/$helper" ]; then
    cp -a -- "$SCRIPT_DIR/$helper" "$OUTPUT/scripts/$helper"
    chmod +x "$OUTPUT/scripts/$helper"
  fi
done
if [ -f "$SCRIPT_DIR/../README.md" ]; then
  cp -a -- "$SCRIPT_DIR/../README.md" "$OUTPUT/README.md"
elif [ -f "$SCRIPT_DIR/README.md" ]; then
  cp -a -- "$SCRIPT_DIR/README.md" "$OUTPUT/README.md"
fi

cat >"$OUTPUT/README.txt" <<'EOF'
Timestamped Omarchy dotfiles backup of ~/.config/hypr and ~/.config/omarchy
(personal home-directory and other application configs excluded).

- manifest/system.txt        source system and Omarchy version
- manifest/files.tsv         every backed-up file, original path, mode, SHA-256
- manifest/checksums.sha256  verification checksums
- manifest/keybindings.txt   live keybindings at backup time
- packages/                  explicit and foreign package lists

Verify:  ./scripts/verify.sh
List:    ./scripts/restore.sh --list
Restore: ./scripts/restore.sh --category hypr --dry-run
EOF

FILE_COUNT=$(wc -l <"$OUTPUT/manifest/checksums.sha256" | tr -d ' ')
SIZE=$(du -sh "$OUTPUT" | cut -f1)

log ""
log "Backup complete: $OUTPUT"
log "Files checksummed: $FILE_COUNT"
log "Size: $SIZE"
log "Verify with: $SCRIPT_DIR/verify.sh \"$OUTPUT\""
