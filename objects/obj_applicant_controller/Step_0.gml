/// Step Event

// DEBUG
if (keyboard_check_pressed(ord("C"))) {
    show_debug_message("=== CONTROLLER DEBUG ===");
    show_debug_message("waiting_for_report_read: " + string(waiting_for_report_read));
    show_debug_message("report_was_closed: " + string(report_was_closed));
    show_debug_message("spawn_delay_timer: " + string(spawn_delay_timer));
    show_debug_message("month_in_progress: " + string(month_in_progress));
    show_debug_message("current_applicant: " + string(current_applicant));
}

// NEW: Handle report close delay FIRST (before the waiting_for_report_read check)
if (report_was_closed) {
    spawn_delay_timer++;
    
    // show_debug_message("Delay timer: " + string(spawn_delay_timer) + " / " + string(spawn_delay_duration));
    
    if (spawn_delay_timer >= spawn_delay_duration) {
        // Delay complete - allow spawning
        report_was_closed = false;
        waiting_for_report_read = false;
        spawn_timer = spawn_delay;  // Reset to trigger immediate spawn
        
        show_debug_message("Spawn delay complete - applicants can now spawn");
    }
    
    return;  // Don't process spawning yet
}

// Don't spawn applicants if still waiting for report to be read
if (waiting_for_report_read) {
    return;
}

// Spawn applicants if month is in progress
if (month_in_progress) {
    spawn_timer++;
    
    if (spawn_timer >= spawn_delay && current_applicant == noone) {
        spawn_next_applicant();
    }
}