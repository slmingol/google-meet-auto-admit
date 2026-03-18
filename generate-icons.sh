#!/bin/bash
# Generate simple icons for Google Meet Auto Admit extension using ImageMagick

cd "$(dirname "$0")"

# Colors
GREEN="#34a853"  # Google green
WHITE="#FFFFFF"

# Function to create an icon
create_icon() {
    local size=$1
    local filename="icon${size}.png"
    local padding=$((size / 8))
    local circle_size=$((size - padding * 2))
    local check_width=$((size / 12))
    if [ $check_width -lt 2 ]; then check_width=2; fi
    
    echo "Creating $filename..."
    
    # Create base image with transparent background
    convert -size ${size}x${size} xc:none \
        -fill "$GREEN" \
        -draw "circle $((size/2)),$((size/2)) $((size/2)),$padding" \
        -stroke "$WHITE" \
        -strokewidth $check_width \
        -fill none \
        -draw "path 'M $((size*3/10)),$((size/2)) L $((size*44/100)),$((size*63/100)) L $((size*7/10)),$((size*37/100))'" \
        "$filename"
    
    echo "✓ Created $filename"
}

# Generate all three sizes
create_icon 16
create_icon 48
create_icon 128

echo ""
echo "All icons created successfully!"
echo "Icons feature a green circle with a white checkmark"
