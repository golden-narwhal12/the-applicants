/// Draw Event

draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(text_color);
draw_set_alpha(alpha);

// Slightly larger font
draw_text_transformed(x, y, feedback_text, 1.3, 1.3, 0);

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);