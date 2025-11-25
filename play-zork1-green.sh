#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
FG_COLOR="${ZORK_GREEN_FG:-#6eff6e}"
BG_COLOR="${ZORK_GREEN_BG:-#000000}"
RESET_FG="${ZORK_GREEN_RESET_FG:-#d0d0d0}"
RESET_BG="${ZORK_GREEN_RESET_BG:-#000000}"
set_colors() {
  printf '\e]10;%s\a\e]11;%s\a' "$1" "$2"
}
trap 'set_colors "$RESET_FG" "$RESET_BG"' EXIT
set_colors "$FG_COLOR" "$BG_COLOR"
exec "$SCRIPT_DIR/play-zork1.sh" "$@"
