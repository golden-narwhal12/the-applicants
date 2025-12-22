/// Draw Event

draw_set_alpha(alpha);

// Draw dark overlay
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);

// Draw game over text
draw_set_color(c_red);
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var center_x = room_width / 2;
var center_y = room_height / 2;

// Main text
draw_text_ext(center_x, center_y - 100, "COLONY COLLAPSED", 30, room_width - 100);

// Reason
draw_set_color(c_white);
if (variable_global_exists("loss_reason")) {
    draw_text_ext(center_x, center_y - 50, global.loss_reason, 20, room_width - 100);
}

// Stats
draw_set_color(c_ltgray);
var stats_text = "MONTH " + string(global.current_month) + " REACHED\n\n";
stats_text += "FINAL RESOURCES:\n";
stats_text += "Food: " + string(max(0, global.food)) + "\n";
stats_text += "Water: " + string(max(0, global.water)) + "\n";
stats_text += "Energy: " + string(max(0, global.energy)) + "\n";
stats_text += "Spirit: " + string(max(0, global.spirit));

draw_text_ext(center_x, center_y + 50, stats_text, 20, room_width - 100);

// Reset
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);