#!/bin/bash
# Generate icons for Google Meet Auto Admit extension using ImageMagick
# Creates Google Meet camera icon with checkmark overlay
# Optimized for maximum visibility in toolbar

cd "$(dirname "$0")"

# Colors - using bolder, more solid colors
BLUE="#1a73e8"      # Google Meet blue
DARKER_BLUE="#0d47a1"  # Much darker blue for contrast
WHITE="#FFFFFF"
GREEN="#2e7d32"     # Darker green for better visibility
LIGHT_GREEN="#4caf50"  # Lighter green for checkmark badge

# Function to create an icon
create_icon() {
    local size=$1
    local filename="icon${size}.png"
    
    # For 16px, use ultra-bold, maximized design for toolbar
    if [ $size -eq 16 ]; then
        echo "Creating $filename (${size}x${size}) - ultra-bold toolbar version..."
        
        # Maximum fill - use entire canvas with thick, solid shapes
        convert -size ${size}x${size} xc:none \
            -fill "$BLUE" \
            -draw "roundrectangle 0,0 14,16 1,1" \
            -draw "polygon 14,3 16,8 14,13" \
            -fill "$WHITE" \
            -draw "circle 7,8 10,8" \
            -fill "$GREEN" \
            -draw "circle 13,13 16,13" \
            -stroke "$WHITE" -strokewidth 3 -fill none \
            -strokelinecap round -strokelinejoin round \
            -draw "path 'M 10.5,13 L 12,14.5 L 15.5,11'" \
            "$filename"
        
        echo "✓ Created $filename"
        return
    fi
    
    echo "Creating $filename (${size}x${size})..."
    
    # Ultra-simple bold design - large solid camera with large checkmark
    # Camera takes up 85% of canvas
    local camera_width=$((size * 85 / 100))
    local camera_height=$((size * 70 / 100))
    local camera_x=$((size * 3 / 100))
    local camera_y=$((size * 12 / 100))
    local corner_radius=$((size / 10))
    
    # Large white circle on camera for contrast
    local circle_cx=$((size * 32 / 100))
    local circle_cy=$((size * 47 / 100))
    local circle_radius=$((size * 18 / 100))
    
    # Large checkmark badge - 55% of icon size
    local badge_radius=$((size * 28 / 100))
    local badge_cx=$((size * 72 / 100))
    local badge_cy=$((size * 72 / 100))
    local check_stroke=$((size / 9))
    if [ $check_stroke -lt 4 ]; then check_stroke=4; fi
    
    # Create maximally bold icon
    convert -size ${size}x${size} xc:none \
        -fill "$BLUE" \
        -draw "roundrectangle $camera_x,$camera_y $((camera_x + camera_width)),$((camera_y + camera_height)) $corner_radius,$corner_radius" \
        -fill "$WHITE" \
        -draw "circle $circle_cx,$circle_cy $((circle_cx + circle_radius)),$circle_cy" \
        -fill "$LIGHT_GREEN" \
        -draw "circle $badge_cx,$badge_cy $((badge_cx + badge_radius)),$badge_cy" \
        -stroke "$WHITE" -strokewidth $check_stroke -fill none \
        -draw "path 'M $((badge_cx - badge_radius/2)),$badge_cy L $((badge_cx - badge_radius/6)),$((badge_cy + badge_radius/2)) L $((badge_cx + badge_radius/2)),$((badge_cy - badge_radius/3))'" \
        "$filename"
    
    echo "✓ Created $filename"
}

# Generate icon sizes that Chrome uses (16, 48, 128)
create_icon 16
create_icon 48
create_icon 128

echo ""
echo "All icons created successfully!"
echo "Icons feature Google Meet camera icon with green checkmark badge"
