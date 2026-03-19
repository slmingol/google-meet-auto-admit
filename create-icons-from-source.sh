#!/bin/bash
# Create extension icons from source image

cd "$(dirname "$0")"

if [ ! -f "source-icon.png" ]; then
    echo "Error: source-icon.png not found"
    exit 1
fi

echo "Creating icons from source-icon.png..."

# Create 16x16 icon - make image 150% bigger, filling more of the canvas
convert source-icon.png -resize 24x24 -background none -gravity center -extent 16x16 icon16.png
echo "✓ Created icon16.png"

# Create 48x48 icon - make image 150% bigger
convert source-icon.png -resize 72x72 -background none -gravity center -extent 48x48 icon48.png
echo "✓ Created icon48.png"

# Create 128x128 icon - make image 150% bigger
convert source-icon.png -resize 192x192 -background none -gravity center -extent 128x128 icon128.png
echo "✓ Created icon128.png"

echo ""
echo "All icons created from source image!"
