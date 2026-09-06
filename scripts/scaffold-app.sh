#!/usr/bin/env bash
# Scaffold a placeholder app-pages folder from _template/.
#
# Usage:
#   scripts/scaffold-app.sh <app-slug> [destination-dir]
#
# With no destination, creates ./<app-slug> in this repo.
# With a destination, copies the template there instead — e.g. into the
# app's own repo, so an agent working there (with access to the app's real
# source and behavior) can fill it in directly. Bring the finished folder
# back with scripts/import-app.sh.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$REPO_ROOT/_template"

SLUG="${1:?Usage: scaffold-app.sh <app-slug> [destination-dir]}"
DEST="${2:-$REPO_ROOT/$SLUG}"

if [ -e "$DEST" ]; then
  echo "Error: $DEST already exists. Remove it or pick a different destination." >&2
  exit 1
fi

cp -R "$TEMPLATE_DIR" "$DEST"

echo "Scaffolded placeholder app pages at: $DEST"
echo
echo "Next steps:"
echo "1. Fill it in — ideally by handing '$DEST' to an agent working inside the"
echo "   app's own repo, so it can read the app's real source/behavior. It should:"
echo "     - replace every [App Name] / support@example.com placeholder in"
echo "       index.html and privacy.html"
echo "     - fill in metadata/*.md with real details (never invented)"
echo "     - replace icon.png with the real 1024x1024 app icon"
echo "     - remove the yellow placeholder banners and <!-- TODO --> comment blocks"
echo "2. Bring the finished folder back into this repo with:"
echo "     $SCRIPT_DIR/import-app.sh <finished-folder-path> $SLUG"
