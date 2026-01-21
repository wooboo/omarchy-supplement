#!/bin/sh
export REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
sudo pacman -Syyu --noconfirm
# Source all scripts in the steps folder
for script in "$REPO_ROOT/steps"/*.sh; do
    if [ -f "$script" ]; then
        source "$script"
    fi
done
