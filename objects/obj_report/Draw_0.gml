/// Draw Event

if (!is_array(text_lines) || array_length(text_lines) == 0) {
    return; // Don't draw if no text
}

// Draw the main report sprite first
draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 
                image_angle, image_blend, image_alpha);

// NEW: Draw flashing indicator if new report (FIXED positioning and depth)
if (has_new_report && indicator_visible && sprite_exists(spr_new_report_indicator)) {
    // Draw at absolute position (not relative to report rotation)
    var indicator_x = 286;
    var indicator_y = 719;
    var indicator_scale = 0.2;  // Scale 256x256 down to ~50px
    
    draw_sprite_ext(spr_new_report_indicator, 0, indicator_x, indicator_y,
                   indicator_scale, indicator_scale, 0, c_white, 1);
}

// Draw text overlay when centered
if (is_centered && text_alpha > 0 && array_length(text_lines) > 0) {
    draw_set_alpha(text_alpha);
    draw_set_color(text_color);
    draw_set_font(text_font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    // Calculate safe text area based on centered report
    // Sprite is rotated 270 degrees, so width and height are swapped
    var report_width = sprite_get_width(sprite_index) * center_scale_x;
    var report_height = sprite_get_height(sprite_index) * center_scale_y;
    
    // Account for rotation (270 degrees means width becomes height)
    var safe_width = report_height * 0.8;  // 80% of rotated width for padding
    var safe_height = report_width * 0.8;  // 80% of rotated height for padding
    
    var text_x = center_x - safe_width / 2;
    var text_y = center_y - safe_height / 2;
    
    var current_y = text_y + 20;  // Top padding
    
    for (var i = 0; i < array_length(text_lines); i++) {
        var line = text_lines[i];
        
        // Draw wrapped text
        draw_text_ext(text_x + 20, current_y, line, line_height, safe_width - 40);
        
        // Calculate height of this wrapped text block
        var text_block_height = string_height_ext(line, line_height, safe_width - 40);
        current_y += text_block_height + 5;  // Small spacing between lines
        
        // Stop if we exceed safe height
        if (current_y > text_y + safe_height - 20) {
            break;
        }
    }
    
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}


