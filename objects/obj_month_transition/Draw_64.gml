/// Draw GUI Event

draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_alpha(alpha);

// Draw simple text in center of screen
var text_x = display_get_gui_width() / 2;
var text_y = display_get_gui_height() / 2;

// Draw once, large size (no multiple draws for "bold")
draw_text_transformed(text_x, text_y, month_text, 3, 3, 0);

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);