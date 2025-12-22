/// Draw Event

// Draw colony state background at full opacity
if (sprite_exists(current_sprite)) {
    draw_sprite_stretched_ext(current_sprite, 0, visual_x, visual_y, 
                              visual_width, visual_height, c_white, 1);
} else {
    // Fallback: draw colored rectangle
    switch(current_state) {
        case "thriving":
            draw_set_color(make_color_rgb(200, 255, 200));
            break;
        case "stable":
            draw_set_color(make_color_rgb(220, 220, 220));
            break;
        case "declining":
            draw_set_color(make_color_rgb(180, 150, 150));
            break;
        case "critical":
            draw_set_color(make_color_rgb(120, 80, 80));
            break;
    }
    draw_set_alpha(0.5);
    draw_rectangle(visual_x, visual_y, visual_x + visual_width, 
                   visual_y + visual_height, false);
    draw_set_alpha(1);
}