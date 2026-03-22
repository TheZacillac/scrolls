#!/usr/bin/env bash
# Setup shell completions for seer

set -euo pipefail

case "${1:-$(basename "$SHELL")}" in
  bash)
    mkdir -p ~/.local/share/bash-completion/completions
    seer completions bash > ~/.local/share/bash-completion/completions/seer
    echo "Bash completions installed."
    ;;
  zsh)
    mkdir -p ~/.zfunc
    seer completions zsh > ~/.zfunc/_seer
    echo "Zsh completions installed. Add 'fpath+=~/.zfunc' to your .zshrc if not already present."
    ;;
  fish)
    mkdir -p ~/.config/fish/completions
    seer completions fish > ~/.config/fish/completions/seer.fish
    echo "Fish completions installed."
    ;;
  *)
    echo "Usage: $0 [bash|zsh|fish]"
    echo "Defaults to your current shell if not specified."
    exit 1
    ;;
esac
