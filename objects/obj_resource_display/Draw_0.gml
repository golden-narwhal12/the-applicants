/// Draw Event

draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

var current_y = display_y;

// NEW: Adjust bar width to leave room for text
var bar_display_width = 200;  // Shortened from 290
var text_offset_x = bar_display_width + 50;  // Position for value text

for (var i = 0; i < array_length(resources); i++) {
    var res = resources[i];
    var value = 0;
    var max_value = 50;
    
    // Get current value
    switch(res.name) {
        case "FOOD":
            value = global.food;
            max_value = global.max_food;
            break;
        case "WATER":
            value = global.water;
            max_value = global.max_water;
            break;
        case "ENERGY":
            value = global.energy;
            max_value = global.max_energy;
            break;
        case "SPIRIT":
            value = global.spirit;
            max_value = global.max_spirit;
            break;
    }
    
    // NEW: Draw icon with scaling (if sprite exists)
    if (sprite_exists(res.icon)) {
        var icon_width = sprite_get_width(res.icon);
        var icon_height = sprite_get_height(res.icon);
        var icon_scale = 32 / max(icon_width, icon_height);  // Scale to 32px
        
        draw_sprite_ext(res.icon, 0, display_x + 16, current_y + bar_height/2,
                       icon_scale, icon_scale, 0, c_white, 1);
    }
    
    // Draw label
    draw_set_color(c_white);
    draw_text(display_x + 40, current_y + 10, res.name);
    
    // Draw bar background
    draw_set_color(c_dkgray);
    draw_rectangle(display_x + 40, current_y + 25, 
                   display_x + 40 + bar_display_width, current_y + 25 + 20, false);
    
    // Draw bar fill
    var fill_width = (value / max_value) * bar_display_width;
    draw_set_color(res.color);
    draw_rectangle(display_x + 40, current_y + 25,
                   display_x + 40 + fill_width, current_y + 25 + 20, false);
    
    // NEW: Draw bar border in BLACK
    draw_set_color(c_black);
    draw_rectangle(display_x + 40, current_y + 25,
                   display_x + 40 + bar_display_width, current_y + 25 + 20, true);
    
    // Draw value text (positioned to not spill out)
    draw_set_color(c_white);
    draw_text(display_x + text_offset_x, current_y + 35, 
              string(value) + "/" + string(max_value));
    
    current_y += bar_height + bar_spacing;
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);