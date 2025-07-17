#!/bin/bash

# Manual GitHub Pages deployment script
# This script manually creates and pushes to the gh-pages branch

echo "Starting manual GitHub Pages deployment..."

# Create a temporary directory for the gh-pages branch
TEMP_DIR=$(mktemp -d)
echo "Created temporary directory: $TEMP_DIR"

# Clone the repository into the temp directory
git clone https://github.com/tiation/19-trillion-solution.git "$TEMP_DIR"
cd "$TEMP_DIR"

# Create the gh-pages branch (or switch to it if it exists)
git checkout --orphan gh-pages || git checkout gh-pages

# Remove all existing files
rm -rf *
rm -rf .github

# Copy the pre-built static files (you'll need to build these first)
echo "You need to build the project first with Node.js and npm!"
echo "After building, copy the contents of the 'dist' folder to this directory:"
echo "$TEMP_DIR"
echo ""
echo "Then run:"
echo "git add ."
echo "git commit -m 'Deploy to GitHub Pages'"
echo "git push origin gh-pages"

# Clean up
echo "Temporary directory created at: $TEMP_DIR"
echo "Manual steps required to complete deployment."
