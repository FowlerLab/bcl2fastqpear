#!/bin/bash

# Check if correct number of arguments provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <directory_to_search> <name_pattern> <destination_directory>"
    exit 1
fi

# Assign arguments to variables
search_directory=$1
name_pattern=$2
destination_directory=$3

# Create the destination directory if it doesn't exist
mkdir -p "$destination_directory"

# Find and move files
find "$search_directory" -type f -name "*$name_pattern*" -exec mv {} "$destination_directory" \;

echo "Files containing '$name_pattern' have been moved to '$destination_directory'"
