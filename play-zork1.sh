#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ENGINE="$SCRIPT_DIR/frotz/build/dfrotz"
STORY="$SCRIPT_DIR/zork1/COMPILED/zork1.z3"
if [[ ! -x "$ENGINE" ]]; then
  echo "Frotz interpreter not found at $ENGINE" >&2
  exit 1
fi
if [[ ! -f "$STORY" ]]; then
  echo "Zork I story file not found at $STORY" >&2
  exit 1
fi
exec "$ENGINE" "$@" "$STORY"
