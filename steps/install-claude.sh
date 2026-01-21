#!/bin/sh

print_step "Claude" "Installs Claude Code and processes related templates"

yay -S --noconfirm --needed claude-code

TEMPLATE_DIR="$REPO_ROOT/dotfiles/claude"

process_bw_templates "dotfiles-secrets" "$TEMPLATE_DIR" "--merge-json"

safe_stow claude
