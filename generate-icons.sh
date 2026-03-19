#!/bin/bash
# Generate icons for Google Meet Auto Admit extension using ImageMagick
# Creates Google "G" icon with checkmark overlay

cd "$(dirname "$0")"

# Colors
GOOGLE_BLUE="#4285f4"   # Google blue
WHITE="#FFFFFF"
GREEN="#34a853"         # Google green for checkmark

# Function to create an icon
create_icon() {
    local size=$1
    local filename="icon${size}.png"
    
    echo "Creating $filename (${size}x${size})..."
    
    # Google G measurements - maximize size
    local g_radius=$((size * 40 / 100))
    local g_center=$((size / 2))
    local g_stroke=$((size / 6))
    if [ $g_stroke -lt 5 ]; then g_stroke=5; fi
    
    # Checkmark badge (bottom right)
    local badge_radius=$((size * 30 / 100))
    local badge_cx=$((size * 72 / 100))
    local badge_cy=$((size * 72 / 100))
    local check_stroke=$((size / 9))
    if [ $check_stroke -lt 4 ]; then check_stroke=4; fi
    
    # Create bold Google G with checkmark
    convert -size ${size}x${size} xc:none \
        -stroke "$GOOGLE_BLUE" -strokewidth $g_stroke -fill none \
        -draw "arc $((g_center - g_radius)),$((g_center - g_radius)) $((g_center + g_radius)),$((g_center + g_radius)) 90,405" \
        -draw "line $g_center,$((g_center - 2)) $((g_center + g_radius - g_stroke/2)),$((g_center - 2))" \
        -fill "$GREEN" \
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
echo "Icons feature Google G with green checkmark badge"
