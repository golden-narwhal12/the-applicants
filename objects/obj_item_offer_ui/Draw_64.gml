/// Draw GUI Event

if (!show_offer || !variable_global_exists("pending_item_offer")) {
    return;
}

// Don't draw if fully faded out
if (fade_alpha <= 0) {
    return;
}

var offer = global.pending_item_offer;

// NEW: Block all clicks right of x=320 (except our buttons)
if (mouse_check_button_pressed(mb_left) || mouse_check_button_pressed(mb_right)) {
    if (mouse_x > 320) {
        // Check if NOT clicking our buttons first
        var box_width = 400;
        var box_height = 250;
        var box_x = (display_get_gui_width() - box_width) / 2;
        var box_y = (display_get_gui_height() - box_height) / 2;
        
        var accept_x = box_x + 50;
        var accept_y = box_y + box_height - 50;
        var button_width = 120;
        var button_height = 35;
        var decline_x = box_x + box_width - 170;
        
        var clicking_button = point_in_rectangle(mouse_x, mouse_y, accept_x, accept_y, 
                                                 accept_x + button_width, accept_y + button_height) ||
                             point_in_rectangle(mouse_x, mouse_y, decline_x, accept_y,
                                               decline_x + button_width, accept_y + button_height);
        
        if (!clicking_button) {
            // Block this click
            mouse_clear(mb_left);
            mouse_clear(mb_right);
        }
    }
}

// Dim background with fade
draw_set_color(c_black);
draw_set_alpha(0.7 * fade_alpha);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

// Draw offer box
var box_width = 400;
var box_height = 250;
var box_x = (display_get_gui_width() - box_width) / 2;
var box_y = (display_get_gui_height() - box_height) / 2;

draw_set_alpha(fade_alpha);
draw_set_color(c_dkgray);
draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);

draw_set_color(c_white);
draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, true);

// NEW: FIXED - Draw item sprite centered properly (moved up and left)
if (sprite_exists(offer.sprite)) {
    var target_display_size = 80;
    var spr_w = sprite_get_width(offer.sprite);
    var spr_h = sprite_get_height(offer.sprite);
    var max_dimension = max(spr_w, spr_h);
    var scale = target_display_size / max_dimension;
    
    // FIXED: Adjusted position (moved left and up)
    var item_display_x = box_x + 70;  // Changed from 90 to 70
    var item_display_y = box_y + 60;  // Changed from 80 to 60
    
    draw_sprite_ext(offer.sprite, 0, item_display_x, item_display_y, 
                   scale, scale, 0, c_white, fade_alpha);
}

// Draw text with fade
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(fade_alpha);

draw_text(box_x + 120, box_y + 30, "NEW ITEM:");
draw_text(box_x + 120, box_y + 60, offer.item_name);
draw_text_ext(box_x + 20, box_y + 120, offer.item_description, -1, box_width - 40);

// Accept button
var accept_x = box_x + 50;
var accept_y = box_y + box_height - 50;
var button_width = 120;
var button_height = 35;

draw_set_color(c_green);
draw_rectangle(accept_x, accept_y, accept_x + button_width, accept_y + button_height, false);
draw_set_color(c_white);
draw_rectangle(accept_x, accept_y, accept_x + button_width, accept_y + button_height, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(accept_x + button_width/2, accept_y + button_height/2, "ACCEPT");

// Decline button
var decline_x = box_x + box_width - 170;
draw_set_color(c_red);
draw_rectangle(decline_x, accept_y, decline_x + button_width, accept_y + button_height, false);
draw_set_color(c_white);
draw_rectangle(decline_x, accept_y, decline_x + button_width, accept_y + button_height, true);
draw_text(decline_x + button_width/2, accept_y + button_height/2, "DECLINE");

// Handle clicks
if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, accept_x, accept_y, 
                          accept_x + button_width, accept_y + button_height)) {
        // Accept item
        var success = add_item_to_inventory(offer.item_id, offer.item_name, 
                                            offer.item_description, offer.sprite,
                                            offer.given_by, offer.abilities);
        if (!success) {
            show_debug_message("Inventory full!");
        }
        show_offer = false;
        global.pending_item_offer = undefined;
    }
    else if (point_in_rectangle(mouse_x, mouse_y, decline_x, accept_y,
                                decline_x + button_width, accept_y + button_height)) {
        // Decline item
        show_offer = false;
        global.pending_item_offer = undefined;
    }
}

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);