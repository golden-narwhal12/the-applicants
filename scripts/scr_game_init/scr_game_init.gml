function game_init() {
    // Resource globals
    global.food = floor(random_range(8,18));
    global.water = floor(random_range(8,18));
    global.energy = floor(random_range(8,18));
    global.spirit = floor(random_range(8,18));
    
    global.max_food = 50;
    global.max_water = 50;
    global.max_energy = 50;
    global.max_spirit = 50;
    
    // Game state
    global.current_month = 1;
    global.max_month = 12;
    
    // Monthly notes
    global.current_month_notes = [];
    
    // Denied applicants tracking
    global.denied_applicants = [];
    
    // Player inventory
    global.inventory = [];
    
    // Item abilities tracker
    global.has_bluebird = false;
    
    // Item drag lock
    global.item_being_dragged = noone;
    
    // Report read requirement
    global.must_read_report = false;
    
    // NEW: Ensure transition object exists
    if (!instance_exists(obj_transition)) {
        instance_create_depth(0, 0, -9999, obj_transition);
    }
}

/// @desc Check if any resource hit 0 (lose condition)
function check_lose_condition() {
    if (global.food <= 0 || global.water <= 0 || 
        global.energy <= 0 || global.spirit <= 0) {
        
        show_debug_message("=== GAME OVER ===");
        show_debug_message("Food: " + string(global.food));
        show_debug_message("Water: " + string(global.water));
        show_debug_message("Energy: " + string(global.energy));
        show_debug_message("Spirit: " + string(global.spirit));
        
        // Store which resource(s) caused the loss for display
        global.loss_reason = "";
        if (global.food <= 0) global.loss_reason += "FOOD DEPLETED. ";
        if (global.water <= 0) global.loss_reason += "WATER DEPLETED. ";
        if (global.energy <= 0) global.loss_reason += "ENERGY DEPLETED. ";
        if (global.spirit <= 0) global.loss_reason += "MORALE COLLAPSED. ";
        
        // Transition to game over
        room_goto(rm_over);
        
        return true;
    }
    
    return false;
}