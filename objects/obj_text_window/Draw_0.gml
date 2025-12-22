/// Draw Event

// Set up text rendering
if (text_font != -1) {
    draw_set_font(text_font);
}
draw_set_color(text_color);
draw_set_alpha(1);

// Calculate text area
var text_area_x = window_x + text_padding;
var text_area_y = window_y + text_padding;
var text_area_width = window_width - (text_padding * 2);
var text_area_height = window_height - (text_padding * 2);

// LOADING STATE - CENTER THE TEXT
if (state == "loading") {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var center_x = window_x + (window_width / 2);
    var center_y = window_y + (window_height / 2);
    
    draw_set_color(text_color);
    draw_text(center_x, center_y, text_content);
    
    // Draw animated dots
    var dots = "";
    var dot_count = floor((loading_timer / 15) % 4); // Cycle every 15 frames
    repeat(dot_count) {
        dots += ".";
    }
    draw_text(center_x, center_y + 30, dots);
	draw_text(center_x, center_y - 30, dots);
    
    // Reset alignment
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    return; // Skip normal text rendering
}

// NORMAL TEXT RENDERING (for showing_text and idle states)
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Create surface for text rendering if needed
if (!surface_exists(text_surface)) {
    text_surface = surface_create(text_area_width, max(text_area_height, 2000));
}

// Render text to surface
surface_set_target(text_surface);
draw_clear_alpha(c_white, 0);

var current_y = 0;
var max_width = text_area_width;

// Split by newlines to preserve paragraph breaks
var paragraphs = string_split(text_content, "\n");

for (var p = 0; p < array_length(paragraphs); p++) {
    var paragraph = paragraphs[p];
    
    if (paragraph == "") {
        current_y += line_height;
        continue;
    }
    
    var words = string_split(paragraph, " ");
    var current_line = "";
    
    for (var i = 0; i < array_length(words); i++) {
        var word = words[i];
        var test_line = (current_line == "") ? word : current_line + " " + word;
        var test_width = string_width(test_line);
        
        if (test_width > max_width && current_line != "") {
            draw_text(0, current_y, current_line);
            current_y += line_height;
            current_line = word;
        } else {
            current_line = test_line;
        }
    }
    
    if (current_line != "") {
        draw_text(0, current_y, current_line);
        current_y += line_height;
    }
}

text_height = current_y;
surface_reset_target();

// Calculate max scroll
max_scroll = max(0, text_height - text_area_height);


draw_set_color(c_white);

// Only set scissor if values are valid
if (text_area_width > 0 && text_area_height > 0) {
    gpu_set_scissor(text_area_x, text_area_y, text_area_width, text_area_height);
}

//// Set clipping region
////gpu_set_scissor(text_area_x, text_area_y, text_area_width, text_area_height);

// Apply glitch shader if enabled
if (glitch_enabled) {
    glitch_shader_setup(
        glitch_time,
        1.0,
        2,
        5,
        text_area_width,
        text_area_height
    );
}

// Draw the surface with scroll offset
if (surface_exists(text_surface)) {
    draw_surface(text_surface, text_area_x, text_area_y - scroll_offset);
}

// Reset shader
if (glitch_enabled) {
    shader_reset();
}

//// Reset clipping
//gpu_set_scissor(0, 0, display_get_gui_width(), display_get_gui_height());

// Optional: Draw scrollbar
if (max_scroll > 0) {
    var scrollbar_x = window_x + window_width - 10;
    var scrollbar_height = text_area_height;
    var scrollbar_thumb_height = max(20, (text_area_height / text_height) * scrollbar_height);
    var scrollbar_thumb_y = text_area_y + (scroll_offset / max_scroll) * (scrollbar_height - scrollbar_thumb_height);
    
    draw_set_color(c_ltgray);
    draw_set_alpha(0.3);
    draw_rectangle(scrollbar_x, text_area_y, scrollbar_x + 6, text_area_y + scrollbar_height, false);
    
    draw_set_color(c_gray);
    draw_set_alpha(0.6);
    draw_rectangle(scrollbar_x, scrollbar_thumb_y, scrollbar_x + 6, 
                  scrollbar_thumb_y + scrollbar_thumb_height, false);
}

// Draw reveal button if in reveal mode
if (reveal_mode && show_reveal_button) {
    // Position button at bottom of text area
    reveal_button_x = window_x + (window_width - reveal_button_width) / 2;
    reveal_button_y = window_y + window_height - 50;
    
    // Check if mouse is hovering
    var hovering = point_in_rectangle(mouse_x, mouse_y, reveal_button_x, reveal_button_y,
                                     reveal_button_x + reveal_button_width,
                                     reveal_button_y + reveal_button_height);
    
    // Draw button background
    if (global.energy >= 1) {
        draw_set_color(hovering ? c_yellow : c_white);
    } else {
        draw_set_color(c_gray);  // Not enough energy
    }
    draw_set_alpha(hovering ? 0.3 : 0.2);
    draw_rectangle(reveal_button_x, reveal_button_y,
                   reveal_button_x + reveal_button_width,
                   reveal_button_y + reveal_button_height, false);
    
    // Draw button text
    draw_set_alpha(1);
    draw_set_color(global.energy >= 1 ? (hovering ? c_yellow : c_white) : c_gray);
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var button_text = "Learn More? (1 Energy)";
    if (global.energy < 1) {
        button_text = "Not Enough Energy";
    }
    
    draw_text(reveal_button_x + reveal_button_width/2,
              reveal_button_y + reveal_button_height/2,
              button_text);
}

// Reset
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);