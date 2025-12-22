/// Create Event
sprite_index = spr_item_report;
depth = -50;  // Should be negative to draw above items

// Glitch settings
glitch_enabled = false;
glitch_time = 0;

// NEW: Fixed position (no longer draggable in left area)
fixed_x = 159.5;
fixed_y = 895;
fixed_scale_x = 0.5;
fixed_scale_y = 0.5;
fixed_rotation = 270;

// Center position (when clicked)
center_x = 683.172;
center_y = 384.03;
center_scale_x = 0.9;
center_scale_y = 0.9;
center_rotation = 270;

// Set initial position to fixed location
x = fixed_x;
y = fixed_y;
image_xscale = fixed_scale_x;
image_yscale = fixed_scale_y;
image_angle = fixed_rotation;

// Animation state
is_centered = false;
is_animating = false;
anim_progress = 0;
anim_speed = 0.1;

// Text settings
text_lines = get_report_text(global.current_month);
text_alpha = 0;
text_color = c_black;
text_font = -1;
line_height = 16;

// NEW: Report indicator
has_new_report = false;
indicator_blink_timer = 0;
indicator_blink_speed = 30;  // Frames between blinks
indicator_visible = true;