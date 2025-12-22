/// Create Event

fade_state = "none";  // "none", "out", "in"
fade_alpha = 0;
target_room = -1;
fade_color = c_black;

// NEW: Extended duration - 2.5s + 0.75s = 3.25 seconds = 195 frames
total_duration = 120;  // Was 150, now 195
fade_timer = 0;

persistent = true;
depth = -9999;

/// scr_transition - transition_to_room function

function transition_to_room(_room) {
    // Safety: Don't transition if already in target room
    if (room == _room) {
        show_debug_message("WARNING: Attempted to transition to current room. Ignoring.");
        return;
    }
    
    with (obj_transition) {
        target_room = _room;
        fade_state = "out";
        fade_alpha = 0;
        fade_timer = 0;
    }
}