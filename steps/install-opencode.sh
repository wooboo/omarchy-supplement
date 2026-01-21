#!/bin/sh

print_step "OpenCode" "Installs OpenCode and its plugins, processes templates"

yay -S --noconfirm --needed opencode-bin

# Install oh-my-opencode and plugins
if command -v bun >/dev/null 2>&1; then
    echo "Installing and configuring oh-my-opencode..."
    # Using automated flags: no-tui, and assuming yes for subscriptions based on current config patterns
    bunx oh-my-opencode install --no-tui --claude=no --chatgpt=no --gemini=no
elif command -v npm >/dev/null 2>&1; then
    echo "Installing and configuring oh-my-opencode via npx..."
    npx oh-my-opencode install --no-tui --claude=no --chatgpt=no --gemini=no
fi

TEMPLATE_DIR="$REPO_ROOT/dotfiles/opencode"

process_bw_templates "dotfiles-secrets" "$TEMPLATE_DIR" "--merge-json"

safe_stow opencode
