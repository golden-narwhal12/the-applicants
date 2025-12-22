/// Title Button Click Event

// Initialize game
game_init();

// Ensure transition exists
if (!instance_exists(obj_transition)) {
    instance_create_depth(0, 0, -9999, obj_transition);
}

// Transition to game room
transition_to_room(rm_game);

// Create Month 1 text overlay
var month_trans = instance_create_depth(0, 0, -10000, obj_month_transition);
month_trans.month_text = "Month 1";
month_trans.persistent = true;  // Survive room change