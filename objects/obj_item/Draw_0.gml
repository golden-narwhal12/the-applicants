/// Draw Event

// Calculate scale to fit target size
var scale_x = 1;
var scale_y = 1;

if (sprite_exists(item_sprite)) {
    var spr_w = sprite_get_width(item_sprite);  // Changed from sprite_width
    var spr_h = sprite_get_height(item_sprite);  // Changed from sprite_height
    
    // Calculate scale to fit target_size while maintaining aspect ratio
    var max_dimension = max(spr_w, spr_h);
    var scale = target_size / max_dimension;
    
    scale_x = scale;
    scale_y = scale;
    
    // Draw item sprite with scaling
    var frame = clamp(item_quantity - 1, 0, sprite_get_number(item_sprite) - 1);
    draw_sprite_ext(item_sprite, frame, x, y, scale_x, scale_y, 0, c_white, 1);
}

// Draw dynamic highlight if being dragged
if (is_dragging) {
		
    // Pulsing glow effect
    var pulse = sin(current_time / 100) * 0.3 + 0.7;  // Oscillates between 0.4 and 1.0
    
    // Draw multiple circles for glow effect
    draw_set_alpha(0.3 * pulse);
    draw_set_color(c_yellow);
    draw_circle(x, y, target_size / 2 + 8, false);
    
    draw_set_alpha(0.5 * pulse);
    draw_circle(x, y, target_size / 2 + 5, false);
    
    draw_set_alpha(0.8 * pulse);
    draw_set_color(c_white);
    draw_circle(x, y, target_size / 2 + 2, true);
    draw_circle(x, y, target_size / 2 + 3, true);
    
    draw_set_alpha(0.5);
	
}

// Draw tooltip
if (showing_tooltip) {
    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var tooltip_x = mouse_x + 15;
    var tooltip_y = mouse_y + 15;
    var tooltip_width = 200;
    var tooltip_text = item_name + "\n" + item_description;
    var tooltip_height = string_height_ext(tooltip_text, -1, tooltip_width - 10) + 10;
    
    // Background
    draw_set_color(c_black);
    draw_set_alpha(0.9);
    draw_rectangle(tooltip_x, tooltip_y, tooltip_x + tooltip_width, 
                   tooltip_y + tooltip_height, false);
    
    // Border
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(tooltip_x, tooltip_y, tooltip_x + tooltip_width,
                   tooltip_y + tooltip_height, true);
    
    // Text
    draw_set_color(c_white);
    draw_text_ext(tooltip_x + 5, tooltip_y + 5, tooltip_text, -1, tooltip_width - 10);
    
    draw_set_alpha(1);
}

// Draw context menu
if (showing_context_menu) {
    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var menu_width = 200;  // size of context menu
    var menu_height = 90; 
    var menu_x = context_menu_x;
    var menu_y = context_menu_y;
    
    // Background
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(menu_x, menu_y, menu_x + menu_width, menu_y + menu_height, false);
    
    // Border
    draw_set_alpha(1);
    draw_set_color(c_gray);
    draw_rectangle(menu_x, menu_y, menu_x + menu_width, menu_y + menu_height, true);
    
    // Menu options
    var option_y = menu_y + 10;
    var option_height = 25;  // Changed from 20 to 25 for more space
    
    // Option 1: Give to Applicant
    draw_set_color(c_white);
    if (point_in_rectangle(mouse_x, mouse_y, menu_x, option_y, 
                          menu_x + menu_width, option_y + option_height)) {
        draw_set_color(c_yellow);
        
        if (mouse_check_button_pressed(mb_left)) {
            with (obj_applicant) {
                if (state == "showing_profile") {
                    other.give_item_to_applicant();
                }
            }
            showing_context_menu = false;
        }
    }
    draw_text(menu_x + 10, option_y, "> Give to Applicant");
    option_y += option_height;
    
    // Option 2: Give to Community
    draw_set_color(c_white);
    if (point_in_rectangle(mouse_x, mouse_y, menu_x, option_y,
                          menu_x + menu_width, option_y + option_height)) {
        draw_set_color(c_yellow);
        
        if (mouse_check_button_pressed(mb_left)) {
            give_item_to_community();
            showing_context_menu = false;
        }
    }
    draw_text(menu_x + 10, option_y, "> Give to Community");
    option_y += option_height;
    
    // Option 3: Discard
    draw_set_color(c_white);
    if (point_in_rectangle(mouse_x, mouse_y, menu_x, option_y,
                          menu_x + menu_width, option_y + option_height)) {
        draw_set_color(c_red);
        
        if (mouse_check_button_pressed(mb_left)) {
            discard_item();
            showing_context_menu = false;
        }
    }
    draw_text(menu_x + 10, option_y, "> Discard");
    
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}