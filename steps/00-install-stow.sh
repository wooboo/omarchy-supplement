#!/bin/sh

echo "Applying configurations via stow..."

# Base packages that don't have their own installation scripts
safe_stow bash
safe_stow starship
safe_stow fastfetch
safe_stow git


