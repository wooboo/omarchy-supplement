#!/bin/bash

# Function to backup a file if it exists and differs from a new version
# Usage: backup_if_changed <target_file> <new_file_source>
backup_if_changed() {
    local TARGET="$1"
    local NEW_SOURCE="$2"
    local TIMESTAMP=$(date +%Y%m%d_%H%M%S)

    if [ ! -f "$TARGET" ]; then
        return 0
    fi

    if cmp -s "$TARGET" "$NEW_SOURCE"; then
        return 0
    fi

    local BACKUP="${TARGET}.${TIMESTAMP}.bak"
    echo "Changes detected in $TARGET. Backing up to $BACKUP"
    
    # Show diff
    if command -v colordiff >/dev/null 2>&1; then
        colordiff -u "$TARGET" "$NEW_SOURCE"
    else
        diff -u --color=always "$TARGET" "$NEW_SOURCE"
    fi

    cp "$TARGET" "$BACKUP"
}

# Function to safely stow a package with backup
# Usage: safe_stow <package_name> [stow_dir_path]
safe_stow() {
    local PACKAGE="$1"
    # Default STOW_DIR logic matching 00-install-stow.sh
    if [ -n "$2" ]; then
        local STOW_DIR="$2"
    else
        [ -d "dotfiles" ] && STOW_DIR="dotfiles" || STOW_DIR="../dotfiles"
    fi

    if [ ! -d "$STOW_DIR/$PACKAGE" ]; then
        echo "Error: Package $PACKAGE not found in $STOW_DIR"
        return 1
    fi

    echo "Processing stow package: $PACKAGE"

    # Iterate through files in the stow package to check for conflicts
    find "$STOW_DIR/$PACKAGE" -type f | while read -r source_file; do
        # Calculate relative path from package root
        # source_file: dotfiles/bash/.bashrc
        # rel_path: .bashrc
        local rel_path="${source_file#$STOW_DIR/$PACKAGE/}"
        local target_file="$HOME/$rel_path"

        # Check if target exists and is NOT a symlink to our source
        if [ -e "$target_file" ]; then
             # If it's a symlink, check where it points
            if [ -L "$target_file" ]; then
                 local current_target=$(readlink -f "$target_file")
                 local expected_source=$(readlink -f "$source_file")
                 if [ "$current_target" = "$expected_source" ]; then
                     continue # Already correctly stowed
                 fi
            fi
            
            # If we are here, it's either a regular file or a wrong symlink
            # Check diff (backup_if_changed expects a source file to compare against)
            backup_if_changed "$target_file" "$source_file"
            
            echo "Removing existing conflict: $target_file"
            rm -rf "$target_file"
        fi
    done

    stow -t "$HOME" -d "$STOW_DIR" "$PACKAGE"
}
