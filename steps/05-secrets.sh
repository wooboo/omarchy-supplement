#!/bin/bash

# Global dotfiles-secrets already handled in steps/01-secrets-helper.sh or individual steps
# If you have general templates not tied to a specific app, put them in templates/global
TEMPLATE_DIR="$REPO_ROOT/templates/global"

process_bw_templates "dotfiles-secrets" "$TEMPLATE_DIR"
