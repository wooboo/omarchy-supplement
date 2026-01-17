#!/bin/sh

yay -S --noconfirm --needed mc
rm -rf ~/.config/mc
[ -d "dotfiles" ] && STOW_DIR="dotfiles" || STOW_DIR="../dotfiles"
stow -t "$HOME" -d "$STOW_DIR" mc
