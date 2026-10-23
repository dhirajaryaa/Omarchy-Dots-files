#!/usr/bin/env bash
# Restore selected categories from an Omarchy dotfiles backup.
# Verifies checksums first, refuses silent overwrites, and saves replaced files.

set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
HOME_DIR=${HOME:?HOME is not set}
if [ -f "$SCRIPT_DIR/manifest/checksums.sha256" ]; then
  ROOT=$SCRIPT_DIR
else
  ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd)
fi
ASSUME_YES=0
DRY_RUN=0
STAMP=$(date +%Y-%m-%d_%H%M%S)
BACKUP_DIR="$HOME_DIR/.local/state/omarchy-dotfiles/restore-backup/$STAMP"
SELECTED=()
PATHS=()
CREATED=0
REPLACED=0
UNCHANGED=0
SKIPPED=0

die() { printf 'error: %s\n' "$*" >&2; exit 1; }
log() { printf '%s\n' "$*"; }
warn() { printf 'warning: %s\n' "$*" >&2; }

usage() {
  cat <<'EOF'
Usage: restore.sh --category NAME [--category NAME ...] [options]

Options:
  --category NAME   Category to restore (repeatable, comma-separated allowed).
  --all             Same as --category all.
  --root DIR        Backup root (default: parent of this script).
  --list            List categories and exit.
  --dry-run         Show actions without changing anything.
  --yes             Do not prompt; still backs up every replaced file.
  -h, --help        Show this help.

Checksums are always verified before a restore. Existing files are saved under
~/.local/state/omarchy-dotfiles/restore-backup/<timestamp>/ before replacement.
EOF
}

list_categories() {
  cat <<'EOF'
Categories:
  hypr        Hyprland Lua configs (monitors, input, bindings, looknfeel, autostart)
  shell       Omarchy shell settings: shell.json, shell.toml
  extensions  Omarchy menu extensions (omarchy-menu.jsonc)
  hooks       Custom Omarchy hooks (currently theme-set.d/omazed)
  themes      User themes: aether, snow_black
  plugins     Third-party Quickshell plugins: stappmus.activity-monitor
  wallpapers  Custom wallpapers: backgrounds/solitude
  branding    Screensaver and about text
  all         Everything under config/ (does not install packages)

The backup scope is only ~/.config/hypr and ~/.config/omarchy. Terminal, editor,
Git, AI-agent, browser, app-state, and personal home-directory files are
intentionally excluded.
EOF
}

add_category() {
  local raw=$1 part
  IFS=',' read -ra parts <<<"$raw"
  for part in "${parts[@]}"; do
    part=${part// /}
    [ -n "$part" ] || continue
    SELECTED+=("$part")
  done
}

while (($#)); do
  case "$1" in
    --category)
      (($# >= 2)) || die "--category needs a value"
      add_category "$2"
      shift 2
      ;;
    --all) SELECTED+=("all"); shift ;;
    --root)
      (($# >= 2)) || die "--root needs a directory"
      ROOT=$2
      shift 2
      ;;
    --list) list_categories; exit 0 ;;
    --dry-run) DRY_RUN=1; shift ;;
    --yes) ASSUME_YES=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "unknown option: $1 (try --help)" ;;
  esac
done

if ((${#SELECTED[@]} == 0)); then
  usage
  printf '\nNo category selected. Nothing was changed.\n' >&2
  exit 1
fi

[ -d "$ROOT" ] || die "backup directory not found: $ROOT"
ROOT=$(cd -- "$ROOT" && pwd)
[ -f "$ROOT/manifest/checksums.sha256" ] || die "not a valid backup (missing manifest/checksums.sha256): $ROOT"

# --- verify first ----------------------------------------------------------
log "Verifying backup checksums..."
TMP=$(mktemp "${TMPDIR:-/tmp}/omarchy-restore.XXXXXX")
trap 'rm -f -- "$TMP"' EXIT
if ! (cd -- "$ROOT" && sha256sum -c manifest/checksums.sha256 >"$TMP" 2>&1); then
  grep -v ': OK$' "$TMP" >&2 || cat "$TMP" >&2
  die "checksum verification failed; refusing to restore"
fi
OK=$(grep -c ': OK$' "$TMP" || true)
log "Checksums OK ($OK files)."

# --- version check ---------------------------------------------------------
WANT=$(sed -n 's/^omarchy_version=//p' "$ROOT/manifest/system.txt" 2>/dev/null || true)
if command -v omarchy >/dev/null 2>&1; then
  HAVE=$(omarchy version 2>/dev/null || true)
else
  HAVE=$(cat /usr/share/omarchy/version 2>/dev/null || true)
fi
[ -n "$HAVE" ] || HAVE=unknown
if [ -n "$WANT" ] && [ "$WANT" != "$HAVE" ]; then
  warn "Backup was created with Omarchy $WANT; this system reports $HAVE."
  warn "Config formats can change between Omarchy releases."
  if [ "$ASSUME_YES" -eq 0 ] && [ "$DRY_RUN" -eq 0 ]; then
    read -r -p "Continue anyway? [y/N] " answer || answer=n
    case "$answer" in y|Y) ;; *) die "aborted by user" ;; esac
  fi
fi

dest_for() {
  case "$1" in
    config/*) printf '%s/.config/%s' "$HOME_DIR" "${1#config/}" ;;
    *) die "internal error: unsupported backup path: $1" ;;
  esac
}

ensure_backup_dir() {
  [ -d "$BACKUP_DIR" ] || mkdir -p -- "$BACKUP_DIR"
}

backup_existing() {
  local dest=$1 rel target
  rel=${dest#"$HOME_DIR"/}
  [ "$rel" != "$dest" ] || die "refusing to modify a path outside \$HOME: $dest"
  ensure_backup_dir
  target="$BACKUP_DIR/$rel"
  mkdir -p -- "$(dirname -- "$target")"
  cp -a -- "$dest" "$target"
  log "  saved existing: $target"
}

restore_one() {
  local src=$1 dest=$2
  local src_is_link=0

  [ -L "$src" ] && src_is_link=1

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ -d "$dest" ] && [ ! -L "$dest" ]; then
      die "destination is a directory; refusing to replace: $dest"
    fi
    if [ "$src_is_link" -eq 1 ] && [ -L "$dest" ] &&
      [ "$(readlink "$src")" = "$(readlink "$dest")" ]; then
      log "  unchanged: $dest"
      UNCHANGED=$((UNCHANGED + 1))
      return 0
    fi
    if [ "$src_is_link" -eq 0 ] && [ -f "$dest" ] && cmp -s -- "$src" "$dest"; then
      log "  unchanged: $dest"
      UNCHANGED=$((UNCHANGED + 1))
      return 0
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
      log "  would replace: $dest (existing file would be saved first)"
      REPLACED=$((REPLACED + 1))
      return 0
    fi

    if [ "$ASSUME_YES" -eq 0 ]; then
      printf 'Replace %s? [y/N/a/q] ' "$dest"
      read -r answer || answer=n
      case "$answer" in
        y|Y) ;;
        a|A) ASSUME_YES=1 ;;
        q|Q) die "aborted by user" ;;
        *) log "  skipped: $dest"; SKIPPED=$((SKIPPED + 1)); return 0 ;;
      esac
    fi

    backup_existing "$dest"
    REPLACED=$((REPLACED + 1))
  else
    if [ "$DRY_RUN" -eq 1 ]; then
      log "  would create: $dest"
      CREATED=$((CREATED + 1))
      return 0
    fi
    CREATED=$((CREATED + 1))
  fi

  mkdir -p -- "$(dirname -- "$dest")"
  if [ "$src_is_link" -eq 1 ]; then
    ln -sfn -- "$(readlink "$src")" "$dest"
  else
    cp -a --remove-destination -- "$src" "$dest"
  fi
  log "  restored: $dest"
}

restore_path() {
  local src=$1 abs="$ROOT/$1"
  if [ -d "$abs" ]; then
    while IFS= read -r -d '' f; do
      local rel=${f#"$abs"/}
      restore_one "$f" "$(dest_for "$src/$rel")"
    done < <(find "$abs" \( -type f -o -type l \) -print0 | sort -z)
  elif [ -e "$abs" ] || [ -L "$abs" ]; then
    restore_one "$abs" "$(dest_for "$src")"
  else
    warn "not present in backup, skipped: $src"
  fi
}

for category in "${SELECTED[@]}"; do
  case "$category" in
    hypr) PATHS=(config/hypr) ;;
    shell) PATHS=(config/omarchy/shell.json config/omarchy/shell.toml) ;;
    extensions) PATHS=(config/omarchy/extensions) ;;
    hooks) PATHS=(config/omarchy/hooks) ;;
    themes) PATHS=(config/omarchy/themes) ;;
    plugins) PATHS=(config/omarchy/plugins) ;;
    wallpapers) PATHS=(config/omarchy/backgrounds) ;;
    branding) PATHS=(config/omarchy/branding) ;;
    all) PATHS=(config) ;;
    *) die "unknown category: $category (use --list)" ;;
  esac

  log ""
  log "Category: $category"
  for path in "${PATHS[@]}"; do
    restore_path "$path"
  done
done

log ""
if [ "$DRY_RUN" -eq 1 ]; then
  log "Dry run complete. Would create: $CREATED, would replace: $REPLACED, unchanged: $UNCHANGED, skipped: $SKIPPED."
  log "No files were changed."
else
  log "Restore complete. Created: $CREATED, replaced: $REPLACED, unchanged: $UNCHANGED, skipped: $SKIPPED."
  if [ "$REPLACED" -gt 0 ]; then
    log "Files replaced by this restore were saved under: $BACKUP_DIR"
  fi
fi

cat <<EOF

Manual next steps (not run automatically):
  Hyprland:        hyprctl reload && hyprctl configerrors
  Shell/plugins:   omarchy restart shell
  Themes:          omarchy theme list
                   omarchy theme set aether        # or snow_black
  Wallpaper:       omarchy theme bg set ~/.config/omarchy/backgrounds/solitude/14.jpg
  Plugins:         omarchy plugin list
  Packages:        see packages/README.md in the backup

This restores configuration only. It does not reinstall packages, boot files,
or Omarchy itself.
EOF
