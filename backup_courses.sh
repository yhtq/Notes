#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR=$(pwd)
DEST_DIR="/mnt/c/Users/guo_zi_xun/OneDrive/课程备份"

# Keep the backup folder and log in place before syncing.
mkdir -p "$DEST_DIR"

nix run .#unison-sync -- "$SOURCE_DIR" "$DEST_DIR"