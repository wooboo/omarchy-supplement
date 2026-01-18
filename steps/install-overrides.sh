#!/bin/bash
safe_stow hyprland


HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"
OVERRIDES_CONFIG="$HOME/.config/hypr/overrides.conf"
SOURCE_LINE="source = $OVERRIDES_CONFIG"

# Check if hyprland config exists
if [ ! -f "$HYPRLAND_CONFIG" ]; then
    echo "Hyprland config not found at $HYPRLAND_CONFIG"
    echo "Please install hyprland first"
    return 1
fi

# Check if overrides config exists
if [ ! -f "$OVERRIDES_CONFIG" ]; then
    echo "Overrides config not found at $OVERRIDES_CONFIG"
    return 1
fi

# Backup main config before appending source line
if ! grep -Fxq "$SOURCE_LINE" "$HYPRLAND_CONFIG"; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    echo "Backing up $HYPRLAND_CONFIG to ${HYPRLAND_CONFIG}.${TIMESTAMP}.bak"
    cp "$HYPRLAND_CONFIG" "${HYPRLAND_CONFIG}.${TIMESTAMP}.bak"

    echo "Adding source line to $HYPRLAND_CONFIG"
    echo "" >> "$HYPRLAND_CONFIG"
    echo "$SOURCE_LINE" >> "$HYPRLAND_CONFIG"
    echo "Source line added successfully"
else
    echo "Source line already exists in $HYPRLAND_CONFIG"
fi

# Trigger Hyprland reload
if command -v hyprctl >/dev/null 2>&1; then
    hyprctl reload
else
    touch "$HYPRLAND_CONFIG"
fi

echo "Hyprland overrides setup complete!"