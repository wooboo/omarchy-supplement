#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <package_name> <glob_pattern>"
    exit 1
fi

PACKAGE_NAME=$1
GLOB_PATTERN=$2

REPO_DIR=$(pwd)
DOTFILES_DIR="$REPO_DIR/dotfiles"
PACKAGE_DIR="$DOTFILES_DIR/$PACKAGE_NAME"

mkdir -p "$PACKAGE_DIR"

copy_with_desymlink() {
    local SRC="$1"
    local DEST="$2"
    
    if [ -L "$SRC" ]; then
        REAL_FILE=$(readlink -f "$SRC")
        cp -r "$REAL_FILE" "$DEST"
        echo "Desymlinked and copied $SRC (resolved to $REAL_FILE) to $DEST"
    elif [ -d "$SRC" ]; then
        mkdir -p "$DEST"
        for FILE in "$SRC"/*; do
            copy_with_desymlink "$FILE" "$DEST/$(basename "$FILE")"
        done
    elif [ -f "$SRC" ]; then
        cp -r "$SRC" "$DEST"
        echo "Copied $SRC to $DEST"
    fi
}

echo "Copying files matching pattern '$GLOB_PATTERN' to $PACKAGE_DIR"
for FILE in $HOME/$GLOB_PATTERN; do
    if [ -e "$FILE" ]; then
        DEST_DIR=$(dirname "$FILE" | sed "s|$HOME|$PACKAGE_DIR|")
        mkdir -p "$DEST_DIR"
        copy_with_desymlink "$FILE" "$DEST_DIR/$(basename "$FILE")"
    else
        echo "No matching files found for pattern: $GLOB_PATTERN"
    fi
done
