#!/bin/bash

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE_DIR="$REPO_DIR/templates/global"

process_bw_templates "dotfiles-secrets" "$TEMPLATE_DIR"
