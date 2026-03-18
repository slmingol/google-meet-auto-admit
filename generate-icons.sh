#!/bin/bash
# Generate icons for Google Meet Auto Admit extension using ImageMagick
# Creates Google Meet camera icon with checkmark overlay

cd "$(dirname "$0")"

# Colors
BLUE="#1a73e8"      # Google Meet blue
DARKER_BLUE="#1557b0"  # Darker blue for shading
WHITE="#FFFFFF"
GREEN="#34a853"     # Google green for checkmark
BLACK="#000000"

# Function to create an icon
create_icon() {
    local size=$1
    local filename="icon${size}.png"
    
    # For 16px, use a simpler, bolder design
    if [ $size -eq 16 ]; then
        echo "Creating $filename (${size}x${size}) - simplified toolbar version..."
        
        # Use almost the entire canvas - minimal padding for maximum visibility
        convert -size ${size}x${size} xc:none \
            -fill "$BLUE" \
            -draw "roundrectangle 0,2 12,14 2,2" \
            -draw "polygon 12,5 16,8 12,11" \
            -fill "$DARKER_BLUE" \
            -draw "circle 6,8 9,8" \
            -fill "$GREEN" \
            -draw "circle 12,12 16,12" \
            -stroke "$WHITE" -strokewidth 2 -fill none \
            -draw "path 'M 10,12 L 11.5,13.5 L 14,11'" \
            "$filename"
        
        echo "✓ Created $filename"
        return
    fi
    
    # Scale-dependent measurements for larger sizes
    local camera_width=$((size * 60 / 100))
    local camera_height=$((size * 45 / 100))
    local camera_x=$((size * 20 / 100))
    local camera_y=$((size * 27 / 100))
    local corner_radius=$((size / 16))
    if [ $corner_radius -lt 2 ]; then corner_radius=2; fi
    
    # Lens measurements
    local lens_cx=$((size * 35 / 100))
    local lens_cy=$((size * 50 / 100))
    local lens_radius=$((size * 12 / 100))
    if [ $lens_radius -lt 2 ]; then lens_radius=2; fi
    
    # Triangle (right side of camera)
    local tri_x1=$((camera_x + camera_width))
    local tri_y1=$((camera_y + camera_height / 3))
    local tri_x2=$((tri_x1 + size / 5))
    local tri_y2=$((camera_y + camera_height / 2))
    local tri_x3=$tri_x1
    local tri_y3=$((camera_y + camera_height * 2 / 3))
    
    # Checkmark badge (bottom right)
    local badge_size=$((size * 45 / 100))
    local badge_x=$((size * 60 / 100))
    local badge_y=$((size * 55 / 100))
    local check_stroke=$((size / 18))
    if [ $check_stroke -lt 2 ]; then check_stroke=2; fi
    
    echo "Creating $filename (${size}x${size})..."
    
    # Create the icon with layers
    convert -size ${size}x${size} xc:none \
        \( +clone -fill "$BLUE" \
           -draw "roundrectangle $camera_x,$camera_y $((camera_x + camera_width)),$((camera_y + camera_height)) $corner_radius,$corner_radius" \
           -draw "polygon $tri_x1,$tri_y1 $tri_x2,$tri_y2 $tri_x3,$tri_y3" \
           -fill "$DARKER_BLUE" \
           -draw "circle $lens_cx,$lens_cy $((lens_cx + lens_radius)),$lens_cy" \
        \) \
        -composite \
        \( +clone -fill "$GREEN" \
           -draw "circle $badge_x,$badge_y $((badge_x + badge_size/2)),$badge_y" \
           -fill none -stroke "$WHITE" -strokewidth $check_stroke \
           -draw "path 'M $((badge_x - badge_size/6)),$badge_y L $((badge_x - badge_size/18)),$((badge_y + badge_size/6)) L $((badge_x + badge_size/4)),$((badge_y - badge_size/6))'" \
        \) \
        -composite \
        "$filename"
    
    echo "✓ Created $filename"
}

# Generate all icon sizes (toolbar typically uses 24/48 or 19/38 on different systems)
create_icon 16
create_icon 24
create_icon 32
create_icon 48
create_icon 128

echo ""
echo "All icons created successfully!"
echo "Icons feature Google Meet camera icon with green checkmark badge"
