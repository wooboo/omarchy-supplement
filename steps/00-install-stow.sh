#!/bin/sh

print_step "Dotfiles Linker" "Links basic dotfiles packages using GNU Stow"

echo "Applying configurations via stow..."

# Base packages that don't have their own installation scripts
safe_stow bash
safe_stow starship
safe_stow fastfetch
safe_stow git
safe_stow scripts


