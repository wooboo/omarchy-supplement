#!/bin/sh

yay -S --noconfirm --needed opencode-bin

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE_DIR="$REPO_DIR/templates/opencode"

process_bw_templates "opencode-secrets" "$TEMPLATE_DIR"
