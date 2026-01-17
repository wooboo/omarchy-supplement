#!/bin/sh

yay -S --noconfirm --needed bitwarden

if command -v npm >/dev/null 2>&1; then
    npm install -g @bitwarden/cli
fi

if command -v bw >/dev/null 2>&1; then
    # Only set server if it's not already correct
    if ! bw config list | grep -q '"server": "https://vault.bitwarden.eu"'; then
        # Logout if already logged in to allow server change
        if bw login --check >/dev/null 2>&1; then
            echo "Logging out of Bitwarden to update server URL..."
            bw logout
        fi
        bw config server https://vault.bitwarden.eu
    fi
fi
