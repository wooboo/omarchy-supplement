#!/bin/sh

print_step "Git Credential Manager" "Installs GCM for OAuth authentication with Git remotes"

# Handle conflicts: remove git-credential-manager if git-credential-manager-bin is desired
if pacman -Qi "git-credential-manager" >/dev/null 2>&1 && ! pacman -Qi "git-credential-manager-bin" >/dev/null 2>&1; then
    echo "Removing conflicting package git-credential-manager..."
    sudo pacman -Rns "git-credential-manager" --noconfirm
fi

yay -S --noconfirm --needed git-credential-manager-bin libsecret
