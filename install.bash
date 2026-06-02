#!/usr/bin/bash

set -e

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

### Dotfiles
if ! command -v stow &>/dev/null; then
  sudo apt install stow
fi
stow --target="$HOME" --dir="$REPO" .
