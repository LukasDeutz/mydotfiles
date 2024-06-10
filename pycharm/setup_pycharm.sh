#!/bin/bash

# Set the target directory where you want to create symbolic links
TARGET_DIR="~/.config/"  # Modify this path as needed

# Make sure the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "Target directory does not exist: $TARGET_DIR"
  exit 1
fi

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# Iterate through all directories in the script's directory
for dir in "$SCRIPT_DIR"/*/; do
  # Check if it's a directory
  if [ -d "$dir" ]; then
    DIR_NAME=$(basename "$dir")
    TARGET_SUBDIR="$TARGET_DIR/$DIR_NAME" 
    mkdir -p "$TARGET_SUBDIR" 
    # Iterate through all files in the directory
    for file in "$dir"*; do
      # Check if it's a file
      if [ -f "$file" ]; then
        # Create a symbolic link in the target directory
        ln -sf "$file" "$TARGET_SUBDIR"
        echo "Created symlink for $file in $TARGET_SUBDIR"
      fi
    done
  fi
done

