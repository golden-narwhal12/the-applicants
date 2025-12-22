/// Create Event

// Position and size (x=319-1366, y=0-463)
visual_x = 319;
visual_y = 0;
visual_width = 1047;
visual_height = 463;

// State sprites
state_sprites = {
    thriving: spr_colony_thriving,
    stable: spr_colony_stable,
    declining: spr_colony_declining,
    critical: spr_colony_critical
};

current_state = "stable";
current_sprite = spr_colony_stable;

depth = 275;  // Behind applicants and UI