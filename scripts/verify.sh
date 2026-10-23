#!/usr/bin/env bash
# Verify an Omarchy dotfiles backup against manifest/checksums.sha256.

set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
if [ -f "$SCRIPT_DIR/manifest/checksums.sha256" ]; then
  ROOT=${1:-$SCRIPT_DIR}
else
  ROOT=${1:-$(cd -- "$SCRIPT_DIR/.." && pwd)}
fi

die() { printf 'error: %s\n' "$*" >&2; exit 1; }

[ -d "$ROOT" ] || die "backup directory not found: $ROOT"
ROOT=$(cd -- "$ROOT" && pwd)
[ -f "$ROOT/manifest/checksums.sha256" ] || die "missing $ROOT/manifest/checksums.sha256"

TMP=$(mktemp "${TMPDIR:-/tmp}/omarchy-verify.XXXXXX")
trap 'rm -f -- "$TMP"' EXIT

TOTAL=$(wc -l <"$ROOT/manifest/checksums.sha256" | tr -d ' ')

printf 'Backup: %s\n' "$ROOT"
if [ -f "$ROOT/manifest/system.txt" ]; then
  sed -n -e 's/^snapshot_date=/Snapshot: /p' \
         -e 's/^omarchy_version=/Omarchy: /p' \
         -e 's/^hostname=/Host: /p' \
         -e 's/^current_theme=/Theme: /p' "$ROOT/manifest/system.txt"
fi
printf 'Checking %s files...\n' "$TOTAL"

set +e
(cd -- "$ROOT" && sha256sum -c manifest/checksums.sha256 >"$TMP" 2>&1)
STATUS=$?
set -e

if [ "$STATUS" -ne 0 ]; then
  printf '\nFAILED: checksum verification failed.\n\n' >&2
  grep -v ': OK$' "$TMP" >&2 || cat "$TMP" >&2
  exit 1
fi

OK=$(grep -c ': OK$' "$TMP" || true)
printf 'OK: %s/%s files verified. No checksum mismatches.\n' "$OK" "$TOTAL"
