#!/bin/sh

print_step "Tmux" "Installs Tmux, TPM, and stows configuration"

# Install tmux
yay -S --noconfirm --needed tmux

safe_stow tmux

# Check if tmux is installed
if ! command -v tmux >/dev/null 2>&1; then
  echo "tmux installation failed."
  return 1
fi

TPM_DIR="$HOME/.tmux/plugins/tpm"

# Check if TPM is already installed
if [ -d "$TPM_DIR" ]; then
  echo "TPM is already installed in $TPM_DIR"
else
  echo "Installing Tmux Plugin Manager (TPM)..."
  git clone https://github.com/tmux-plugins/tpm $TPM_DIR
fi

echo "TPM installed successfully!"