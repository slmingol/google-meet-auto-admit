#!/usr/bin/env python3
"""
Generate simple icons for Google Meet Auto Admit extension
"""

from PIL import Image, ImageDraw, ImageFont
import os

def create_icon(size, output_path):
    """Create a simple icon with a green circle and checkmark"""
    # Create image with transparent background
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Draw green circle background
    padding = max(1, size // 8)
    circle_color = (52, 168, 83, 255)  # Google green
    draw.ellipse([padding, padding, size - padding, size - padding], 
                 fill=circle_color)
    
    # Draw white checkmark
    if size >= 32:
        # For larger icons, draw a proper checkmark
        line_width = max(2, size // 12)
        
        # Checkmark coordinates (scaled to icon size)
        scale = size / 48
        check_points = [
            (15 * scale, 24 * scale),
            (21 * scale, 30 * scale),
            (33 * scale, 18 * scale),
        ]
        
        # Draw the checkmark as two lines
        draw.line([check_points[0], check_points[1]], 
                  fill='white', width=line_width, joint='curve')
        draw.line([check_points[1], check_points[2]], 
                  fill='white', width=line_width, joint='curve')
    else:
        # For 16x16, just draw a simple check
        line_width = 2
        draw.line([(5, 8), (7, 10)], fill='white', width=line_width)
        draw.line([(7, 10), (11, 6)], fill='white', width=line_width)
    
    # Save the icon
    img.save(output_path, 'PNG')
    print(f"Created {output_path}")

def main():
    # Get the directory where this script is located
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Create icons in three sizes
    sizes = [16, 48, 128]
    
    for size in sizes:
        output_path = os.path.join(script_dir, f'icon{size}.png')
        create_icon(size, output_path)
    
    print("\nAll icons created successfully!")
    print("Icons feature a green circle with a white checkmark")

if __name__ == '__main__':
    main()
