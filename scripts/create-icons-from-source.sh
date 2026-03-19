#!/bin/bash
# Create extension icons from source image

# Get the repository root directory
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

if [ ! -f "assets/source-icon.png" ]; then
    echo "Error: assets/source-icon.png not found"
    exit 1
fi

echo "Creating icons from assets/source-icon.png..."

# Create 16x16 icon - make image 338% of canvas size
convert assets/source-icon.png -resize 54x54 -background none -gravity center -extent 16x16 icon16.png
echo "✓ Created icon16.png"

# Create 48x48 icon - make image 338% of canvas size
convert assets/source-icon.png -resize 162x162 -background none -gravity center -extent 48x48 icon48.png
echo "✓ Created icon48.png"

# Create 128x128 icon - make image 338% of canvas size
convert assets/source-icon.png -resize 432x432 -background none -gravity center -extent 128x128 icon128.png
echo "✓ Created icon128.png"

echo ""
echo "All icons created from source image!"
