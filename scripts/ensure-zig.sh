#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
ARCHIVE="$ROOT_DIR/downloads/zig-linux-x86_64-0.13.0.tar.xz"
TARGET_DIR="$ROOT_DIR/downloads/zig-linux-x86_64-0.13.0"
if [[ -x "$TARGET_DIR/zig" ]]; then
  echo "Zig toolchain already extracted at $TARGET_DIR" >&2
  exit 0
fi
if [[ ! -f "$ARCHIVE" ]]; then
  echo "Missing $ARCHIVE. Download the archive first." >&2
  exit 1
fi
echo "Extracting Zig toolchain..." >&2
tar -xf "$ARCHIVE" -C "$ROOT_DIR/downloads"
echo "Done." >&2
