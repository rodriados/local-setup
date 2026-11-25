#!/usr/bin/env bash
# Personal workspace setup automation.
# @file The init hook for distrobox modules.
# @author Rodrigo Siqueira <me@rodriados.com>
# @copyright 2026-present Rodrigo Siqueira

readonly MODULE_MISSING_HOST_BINARIES=("fzf" "gawk" "git" "jq" "nano" "xdg-open")

for binary in "${MODULE_MISSING_HOST_BINARIES[@]}"; do
  if ! command -v "$binary" &> /dev/null; then
    sudo ln -s /usr/bin/distrobox-host-exec "/usr/local/bin/$binary"
  fi
done
