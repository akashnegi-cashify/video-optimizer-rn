#!/usr/bin/env bash

#!/bin/bash

# Source file path
source_file="./assets/stage/db.json"

# Array of destination folders
destination_folders=(
  "./assets/prodTest"
  "./assets/beta"
  "./assets"
  # Add more destination folders as needed
)

# Loop through each destination folder and copy the file
for folder in "${destination_folders[@]}"; do
  # Check if the destination folder exists
  if [ -d "$folder" ]; then
    # Copy the file to the destination folder
    cp "$source_file" "$folder"
    echo "File copied to: $folder"
  else
    echo "Destination folder does not exist: $folder"
  fi
done
