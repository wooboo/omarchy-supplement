#!/bin/sh

yay -S --noconfirm --needed opencode-bin

# Install oh-my-opencode and plugins
if command -v bun >/dev/null 2>&1; then
    echo "Installing and configuring oh-my-opencode..."
    # Using automated flags: no-tui, and assuming yes for subscriptions based on current config patterns
    bunx oh-my-opencode install --no-tui --claude=no --chatgpt=no --gemini=yes
elif command -v npm >/dev/null 2>&1; then
    echo "Installing and configuring oh-my-opencode via npx..."
    npx oh-my-opencode install --no-tui --claude=no --chatgpt=no --gemini=yes
fi

TEMPLATE_DIR="$REPO_ROOT/templates/opencode"

process_bw_templates "dotfiles-secrets" "$TEMPLATE_DIR" "--merge-json"
