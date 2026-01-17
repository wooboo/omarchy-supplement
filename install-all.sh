#!/bin/sh
sudo pacman -Syyu --noconfirm
# Source all scripts in the steps folder
for script in steps/*.sh; do
    if [ -f "$script" ]; then
        echo "Sourcing $script..."
        source "$script"
    fi
done
