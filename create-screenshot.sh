#!/bin/bash
# Create a Chrome Web Store screenshot (1280x800) for Auto Admit extension

cd "$(dirname "$0")"

WIDTH=1280
HEIGHT=800

# Colors
BG_COLOR="#ffffff"
MEET_BG="#202124"
HEADER_BG="#3c4043"
TEXT_COLOR="#202124"
SUBTITLE_COLOR="#5f6368"
GREEN="#34a853"
BLUE="#1a73e8"

echo "Creating 1280x800 screenshot for Chrome Web Store..."

# Create base screenshot
convert -size ${WIDTH}x${HEIGHT} xc:"$BG_COLOR" screenshot.png

# Add Google Meet-like header bar
convert screenshot.png \
    -fill "$HEADER_BG" -draw "rectangle 0,0 ${WIDTH},60" \
    screenshot.png

# Add Google Meet logo text area
convert screenshot.png \
    -font Helvetica-Bold -pointsize 24 -fill white \
    -annotate +20+40 "Google Meet" \
    screenshot.png

# Add main content area with dark background (like Meet)
convert screenshot.png \
    -fill "$MEET_BG" -draw "rectangle 20,80 1260,720" \
    screenshot.png

# Add extension popup overlay (centered)
POPUP_X=480
POPUP_Y=200
POPUP_W=320
POPUP_H=280

# Popup background (white rounded rectangle)
convert screenshot.png \
    -fill white -stroke "#dadce0" -strokewidth 1 \
    -draw "roundrectangle $POPUP_X,$POPUP_Y $((POPUP_X+POPUP_W)),$((POPUP_Y+POPUP_H)) 8,8" \
    screenshot.png

# Popup title
convert screenshot.png \
    -font Helvetica-Bold -pointsize 18 -fill "$TEXT_COLOR" \
    -annotate +$((POPUP_X+20))+$((POPUP_Y+35)) "Auto Admit for Google Meet" \
    screenshot.png

# Toggle section background
convert screenshot.png \
    -fill "#f8f9fa" -stroke "#e8eaed" -strokewidth 1 \
    -draw "roundrectangle $((POPUP_X+20)),$((POPUP_Y+60)) $((POPUP_X+POPUP_W-20)),$((POPUP_Y+110)) 6,6" \
    screenshot.png

# Toggle label
convert screenshot.png \
    -font Helvetica -pointsize 14 -fill "$SUBTITLE_COLOR" \
    -annotate +$((POPUP_X+35))+$((POPUP_Y+88)) "Auto Admit" \
    screenshot.png

# Toggle switch (ON position - green)
TOGGLE_X=$((POPUP_X+POPUP_W-80))
TOGGLE_Y=$((POPUP_Y+73))
convert screenshot.png \
    -fill "$GREEN" -draw "roundrectangle $TOGGLE_X,$TOGGLE_Y $((TOGGLE_X+48)),$((TOGGLE_Y+24)) 12,12" \
    -fill white -draw "circle $((TOGGLE_X+39)),$((TOGGLE_Y+12)) $((TOGGLE_X+48)),$((TOGGLE_Y+12))" \
    screenshot.png

# Status message (green background)
convert screenshot.png \
    -fill "#d3f3d6" -stroke "#d3f3d6" -strokewidth 1 \
    -draw "roundrectangle $((POPUP_X+20)),$((POPUP_Y+130)) $((POPUP_X+POPUP_W-20)),$((POPUP_Y+165)) 6,6" \
    -font Helvetica -pointsize 13 -fill "#137333" \
    -annotate +$((POPUP_X+35))+$((POPUP_Y+152)) "✓ Auto-admit is active" \
    screenshot.png

# Info text
convert screenshot.png \
    -font Helvetica -pointsize 12 -fill "$SUBTITLE_COLOR" \
    -annotate +$((POPUP_X+25))+$((POPUP_Y+190)) "This extension automatically admits" \
    -annotate +$((POPUP_X+25))+$((POPUP_Y+208)) "people to your Google Meet when" \
    -annotate +$((POPUP_X+25))+$((POPUP_Y+226)) "they're in the waiting room." \
    screenshot.png

# Version footer
convert screenshot.png \
    -fill "#e8eaed" -draw "line $((POPUP_X+20)),$((POPUP_Y+245)) $((POPUP_X+POPUP_W-20)),$((POPUP_Y+245))" \
    -font Helvetica -pointsize 11 -fill "#9aa0a6" \
    -gravity Center -annotate +0+$((POPUP_Y+265-HEIGHT/2)) "v1.0.13" \
    screenshot.png

# Add feature callouts around the popup
convert screenshot.png \
    -font Helvetica-Bold -pointsize 16 -fill "$BLUE" \
    -annotate +120+300 "✓ Automatic Admission" \
    -font Helvetica -pointsize 13 -fill "$SUBTITLE_COLOR" \
    -annotate +120+325 "No manual clicking needed" \
    screenshot.png

convert screenshot.png \
    -font Helvetica-Bold -pointsize 16 -fill "$BLUE" \
    -annotate +120+380 "✓ Easy Toggle Control" \
    -font Helvetica -pointsize 13 -fill "$SUBTITLE_COLOR" \
    -annotate +120+405 "Turn on/off anytime" \
    screenshot.png

convert screenshot.png \
    -font Helvetica-Bold -pointsize 16 -fill "$BLUE" \
    -annotate +860+300 "✓ Privacy Focused" \
    -font Helvetica -pointsize 13 -fill "$SUBTITLE_COLOR" \
    -annotate +860+325 "No data collection" \
    screenshot.png

convert screenshot.png \
    -font Helvetica-Bold -pointsize 16 -fill "$BLUE" \
    -annotate +860+380 "✓ Real-time Monitoring" \
    -font Helvetica -pointsize 13 -fill "$SUBTITLE_COLOR" \
    -annotate +860+405 "Instant participant admission" \
    screenshot.png

# Add bottom banner
convert screenshot.png \
    -fill "$BLUE" -draw "rectangle 0,740 ${WIDTH},${HEIGHT}" \
    -font Helvetica-Bold -pointsize 20 -fill white \
    -gravity South -annotate +0+35 "Save time • Never miss anyone • Seamless meetings" \
    screenshot.png

echo "✓ Created screenshot.png (1280x800)"
echo ""
echo "Screenshot features:"
echo "  - Extension popup with active toggle"
echo "  - Key features highlighted"
echo "  - Professional Google Meet-style design"
echo "  - Ready for Chrome Web Store submission"
