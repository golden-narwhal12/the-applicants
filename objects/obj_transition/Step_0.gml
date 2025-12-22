/// Step Event

if (fade_state == "out") {
    fade_timer++;
    
    var midpoint = floor(total_duration / 2);
    
    // Fade out over first half
    if (fade_timer < midpoint) {
        fade_alpha = fade_timer / midpoint;
    } else {
        fade_alpha = 1;
    }
    
    // NEW: Use >= instead of == for safety, and only change room once
    if (fade_timer >= midpoint && fade_timer == midpoint) {
        if (room_exists(target_room)) {
            show_debug_message("TRANSITION: Changing to room " + string(target_room));
            room_goto(target_room);
            fade_state = "in";
            fade_timer = 0;  // RESET timer for clean fade-in calculation
            show_debug_message("TRANSITION: Room changed, now fading IN");
        }
    }
}
else if (fade_state == "in") {
    fade_timer++;
    
    var midpoint = floor(total_duration / 2);
    
    // Fade in over second half (now with clean 0-based timer)
    var progress = fade_timer / midpoint;
    fade_alpha = 1 - progress;
    
    show_debug_message("FADE IN: timer=" + string(fade_timer) + " alpha=" + string(fade_alpha));
    
    if (fade_timer >= midpoint) {
        fade_state = "none";
        fade_alpha = 0;
        fade_timer = 0;
        show_debug_message("TRANSITION: Complete");
    }
}