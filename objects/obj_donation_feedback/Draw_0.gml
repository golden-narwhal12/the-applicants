/// Draw Event

draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_lime);
draw_set_alpha(alpha);

draw_text(x, y, feedback_text);

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);