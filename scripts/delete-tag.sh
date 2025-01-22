#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

# Validate the version format (X.X.X)
if ! [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid version format. Please use X.X.X (e.g., 1.0.0)"
    exit 1
fi

# Delete the local tag
git tag -d "v$1"

# Delete the remote tag
git push origin --delete "v$1"

echo "Tag v$1 deleted locally and remotely."
