#!/usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../" && pwd)"
STATUS_DIR="$ROOT_DIR/docs/infra-status"
DATE_STR=$(date +%F)
FILE="$STATUS_DIR/$DATE_STR.md"
EDITOR_CMD="${EDITOR:-vim}"

mkdir -p "$STATUS_DIR"

if [ -f "$FILE" ]; then
  echo "Editing existing status for $DATE_STR: $FILE"
else
  echo "Creating new status file: $FILE"
  cat > "$FILE" <<EOF
# infra status – $DATE_STR

done:


currently running:


what's next:
optional:


must do:


later:
EOF
fi

$EDITOR_CMD "$FILE"
