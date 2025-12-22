/// Draw Event

// Draw the sprite
if (sprite_exists(sprite_index)) {
    draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 
                    image_angle, image_blend, 1);
}

// Draw dynamic attack warning indicator
if (is_attacker && !detained && attack_warning_visible) {
    var warning_x = x + 40;
    var warning_y = y - 100;
    
    // Pulsing effect (gets more intense as timer increases)
    var time_ratio = attack_detonation_timer / attack_detonation_countdown;
    var pulse_speed = lerp(0.05, 0.3, time_ratio);  // Pulse faster as time goes on
    var pulse = sin(current_time * pulse_speed) * 0.5 + 0.5;  // 0.0 to 1.0
    
    // Outer glow (red, pulsing)
    draw_set_alpha(0.3 * pulse);
    draw_set_color(c_red);
    draw_circle(warning_x, warning_y, 20, false);
    
    draw_set_alpha(0.6 * pulse);
    draw_circle(warning_x, warning_y, 15, false);
    
    // Inner circle (solid red)
    draw_set_alpha(1);
    draw_set_color(c_red);
    draw_circle(warning_x, warning_y, 12, false);
    
    // Border
    draw_set_color(c_maroon);
    draw_circle(warning_x, warning_y, 12, true);
    draw_circle(warning_x, warning_y, 13, true);
    
    // Exclamation mark
    draw_set_color(c_white);
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Draw "!" with slight shake as it gets closer to detonation
    var shake_x = random_range(-time_ratio * 2, time_ratio * 2);
    var shake_y = random_range(-time_ratio * 2, time_ratio * 2);
    
    draw_text(warning_x + shake_x, warning_y - 2 + shake_y, "!");
    
    // Optional: Add countdown number below
    var seconds_left = ceil((attack_detonation_countdown - attack_detonation_timer) / 60);
    if (seconds_left <= 3) {
        draw_set_color(c_white);
        draw_set_alpha(pulse);
        draw_text(warning_x, warning_y + 20, string(seconds_left));
        draw_set_alpha(1);
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// Draw timer when showing profile
if (state == "showing_profile") {
    var seconds_left = ceil((decision_duration - decision_timer) / 60);
    
    draw_set_font(-1);
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    
    var timer_text = "TIME: " + string(seconds_left) + "s";
    var padding = 20;
    var text_w = string_width(timer_text) + 30;
    var text_h = string_height(timer_text) + 16;
    
    var timer_x = 1366 - padding;
    var timer_y = padding;
    
    // Timer background
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(timer_x - text_w, timer_y, timer_x, timer_y + text_h, false);
    
    // Timer border
    draw_set_alpha(1);
    draw_set_color(seconds_left <= 10 ? c_red : c_white);
    draw_rectangle(timer_x - text_w, timer_y, timer_x, timer_y + text_h, true);
    
    // Timer text
    draw_set_color(seconds_left <= 10 ? c_red : c_white);
    draw_text(timer_x - 15, timer_y + 8, timer_text);
    
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// Draw speech bubble (during loading or showing_profile state)
if (showing_speech && current_speech_text != "") {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Calculate bubble size
    var bubble_width = min(400, string_width(current_speech_text) + 40);
    var bubble_height = string_height_ext(current_speech_text, -1, bubble_width - 40) + 30;
    
    // Bubble position (above applicant)
    var bubble_x = x;
    var bubble_y = y - 180;
    
    // Draw bubble background
    draw_set_color(c_white);
    draw_set_alpha(0.95);
    draw_roundrect(bubble_x - bubble_width/2, bubble_y - bubble_height/2,
                   bubble_x + bubble_width/2, bubble_y + bubble_height/2, false);
    
    // Draw bubble border
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_roundrect(bubble_x - bubble_width/2, bubble_y - bubble_height/2,
                   bubble_x + bubble_width/2, bubble_y + bubble_height/2, true);
    
    // Draw tail (pointing down to applicant) - WHITE FILL
    draw_set_color(c_white);
    draw_set_alpha(0.95);
    draw_triangle(bubble_x - 15, bubble_y + bubble_height/2,
                  bubble_x + 15, bubble_y + bubble_height/2,
                  bubble_x, bubble_y + bubble_height/2 + 20, false);
    
    // Draw tail border - BLACK OUTLINE
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_line_width(bubble_x - 15, bubble_y + bubble_height/2, bubble_x, bubble_y + bubble_height/2 + 20, 2);
    draw_line_width(bubble_x + 15, bubble_y + bubble_height/2, bubble_x, bubble_y + bubble_height/2 + 20, 2);
    
    // Draw text
    draw_set_color(c_black);
    draw_text_ext(bubble_x, bubble_y, current_speech_text, -1, bubble_width - 40);
    
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
// Draw response bubble (during walking_out state)
if (showing_response && response_text != "") {
    draw_set_font(-1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Calculate bubble size
    var bubble_width = min(300, string_width(response_text) + 40);
    var bubble_height = string_height_ext(response_text, -1, bubble_width - 40) + 30;
    
    // Bubble position
    var bubble_x = x;
    var bubble_y = y - 180;
    
    // Determine color based on decision
    var bubble_color = (decision == "accepted") ? make_color_rgb(200, 255, 200) : make_color_rgb(255, 200, 200);
    
    // Draw bubble background
    draw_set_color(bubble_color);
    draw_set_alpha(0.95);
    draw_roundrect(bubble_x - bubble_width/2, bubble_y - bubble_height/2,
                   bubble_x + bubble_width/2, bubble_y + bubble_height/2, false);
    
    // Draw bubble border
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_roundrect(bubble_x - bubble_width/2, bubble_y - bubble_height/2,
                   bubble_x + bubble_width/2, bubble_y + bubble_height/2, true);
    
    // Draw tail - COLORED FILL
    draw_set_color(bubble_color);
    draw_set_alpha(0.95);
    draw_triangle(bubble_x - 15, bubble_y + bubble_height/2,
                  bubble_x + 15, bubble_y + bubble_height/2,
                  bubble_x, bubble_y + bubble_height/2 + 20, false);
    
    // Draw tail border - BLACK OUTLINE
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_line_width(bubble_x - 15, bubble_y + bubble_height/2, bubble_x, bubble_y + bubble_height/2 + 20, 2);
    draw_line_width(bubble_x + 15, bubble_y + bubble_height/2, bubble_x, bubble_y + bubble_height/2 + 20, 2);
    
    // Draw text
    draw_set_color(c_black);
    draw_text_ext(bubble_x, bubble_y, response_text, -1, bubble_width - 40);
    
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}