/// Draw Event

// Draw button background
draw_set_alpha(hover ? 0.3 : 0.2);
draw_set_color(hover ? c_yellow : c_white);
draw_rectangle(x - button_width/2, y - button_height/2,
               x + button_width/2, y + button_height/2, false);

// Draw button border
draw_set_alpha(1);
draw_set_color(hover ? c_yellow : c_white);
draw_rectangle(x - button_width/2, y - button_height/2,
               x + button_width/2, y + button_height/2, true);

// Draw button text
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(hover ? c_yellow : c_white);
draw_text(x, y, "RESTART");

// Reset draw settings
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);