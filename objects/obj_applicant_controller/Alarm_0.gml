/// Alarm 0 Event

// Advance to next month
if (global.current_month < global.max_month) {
    global.current_month++;
    
    // NEW: Don't restart the room, just show month transition
    var month_trans = instance_create_depth(0, 0, -10000, obj_month_transition);
    month_trans.month_text = "Month " + string(global.current_month);
    
    // Start new month after transition completes (3.25 seconds)
    alarm[4] = 195;  // Match transition duration
} else {
    show_debug_message("Game complete! All months finished.");
    // TODO: Show ending screen
}