/// Step Event

// NEW: Block all item interactions if must read report
if (global.must_read_report) {
    return;
}


var hitbox_size = target_size / 2;
var mouse_over = point_distance(mouse_x, mouse_y, x, y) < hitbox_size;

showing_tooltip = mouse_over && !is_dragging && !showing_context_menu;

// NEW: Check if ANY item is being dragged
var something_else_dragging = (global.item_being_dragged != noone && global.item_being_dragged != id);

// Start dragging (only if nothing else is being dragged)
if (mouse_over && mouse_check_button_pressed(mb_left) && !showing_context_menu && !something_else_dragging) {
    is_dragging = true;
    global.item_being_dragged = id;  // Lock this item as the one being dragged
    drag_offset_x = x - mouse_x;
    drag_offset_y = y - mouse_y;
    showing_context_menu = false;
}

// While dragging
if (is_dragging) {
    x = clamp(mouse_x + drag_offset_x, min_x + hitbox_size, max_x - hitbox_size);
    y = clamp(mouse_y + drag_offset_y, min_y + hitbox_size, max_y - hitbox_size);
}

// Stop dragging
if (mouse_check_button_released(mb_left)) {
    if (is_dragging) {
        is_dragging = false;
        global.item_being_dragged = noone;  // Unlock drag
    }
}

// Right click for context menu (only if nothing is being dragged)
if (mouse_over && mouse_check_button_pressed(mb_right) && !something_else_dragging) {
    showing_context_menu = !showing_context_menu;
    context_menu_x = mouse_x;
    context_menu_y = mouse_y;
}

// Close context menu if clicking elsewhere
if (showing_context_menu && mouse_check_button_pressed(mb_left)) {
    if (!point_in_rectangle(mouse_x, mouse_y, context_menu_x, context_menu_y,
                           context_menu_x + 180, context_menu_y + 90)) {
        showing_context_menu = false;
    }
}