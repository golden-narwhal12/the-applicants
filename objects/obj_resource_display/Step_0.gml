// Smooth resource drain (existing code)
if (draining) {
    var all_reached = true;
    
    if (global.food > drain_targets.food) {
        global.food -= drain_speed;
        if (global.food < drain_targets.food) global.food = drain_targets.food;
        all_reached = false;
    }
    
    if (global.water > drain_targets.water) {
        global.water -= drain_speed;
        if (global.water < drain_targets.water) global.water = drain_targets.water;
        all_reached = false;
    }
    
    if (global.energy > drain_targets.energy) {
        global.energy -= drain_speed;
        if (global.energy < drain_targets.energy) global.energy = drain_targets.energy;
        all_reached = false;
    }
    
    if (global.spirit > drain_targets.spirit) {
        global.spirit -= drain_speed;
        if (global.spirit < drain_targets.spirit) global.spirit = drain_targets.spirit;
        all_reached = false;
    }
    
    if (all_reached) {
        draining = false;
        
        // NEW: Check lose condition after drain completes
        check_lose_condition();
    }
}