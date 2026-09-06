#!/usr/bin/env bash
# Import a finished app-pages folder (filled in elsewhere, e.g. by an agent
# working in the app's own repo) into this repo.
#
# Usage:
#   scripts/import-app.sh <finished-folder-path> <app-slug>
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SRC="${1:?Usage: import-app.sh <finished-folder-path> <app-slug>}"
SLUG="${2:?Usage: import-app.sh <finished-folder-path> <app-slug>}"
DEST="$REPO_ROOT/$SLUG"

if [ ! -d "$SRC" ]; then
  echo "Error: source folder '$SRC' not found." >&2
  exit 1
fi

if [ -e "$DEST" ]; then
  echo "'$DEST' already exists and will be replaced with the finished folder."
  read -r -p "Continue? [y/N] " REPLY
  case "$REPLY" in
    [yY]*) ;;
    *) echo "Aborted."; exit 1 ;;
  esac
  rm -rf "$DEST"
fi

cp -R "$SRC" "$DEST"

echo "Imported finished app pages into: $DEST"
echo
echo "Remaining steps:"
echo "1. Add (or update) an <li class=\"app-card\"> entry for it in the root"
echo "   index.html's <ul class=\"app-grid\">."
echo "2. Double-check the placeholder banners and <!-- TODO --> blocks are gone"
echo "   and there's no leftover [App Name] / support@example.com text."
echo "3. git add, commit, push — GitHub Pages redeploys automatically."
echo "4. Report the live Support and Privacy URLs back to the user."
