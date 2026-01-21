#!/bin/sh

print_step "Midnight Commander" "Installs MC and stows its configuration"

yay -S --noconfirm --needed mc

safe_stow mc
