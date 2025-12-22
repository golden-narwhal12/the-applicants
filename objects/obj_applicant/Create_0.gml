/// Create Event
sprite_index = spr_applicant_general;

// Calculate sprite bounds at starting scale
var start_scale = 0.5;
var half_width = (sprite_get_width(sprite_index) * start_scale) / 2;
var half_height = (sprite_get_height(sprite_index) * start_scale) / 2;

// Positions - adjusted to keep sprite within bounds
start_x = 320 + half_width + 15;
start_y = 450 - half_height;

center_x = 833;
center_y = 275;

// Different exit paths based on decision
exit_x_accepted = 1366 + 200; // Right side exit (accepted)
exit_y_accepted = 452 - half_height;

exit_x_denied = start_x; // Back to start (denied)
exit_y_denied = start_y;

// Starting state
x = start_x;
y = start_y;
image_xscale = start_scale;
image_yscale = start_scale;
image_angle = 0;
image_blend = c_white;

// Animation
anim_progress = 0;
anim_speed = 0.015;

// States: "walking_in", "loading", "showing_profile", "walking_out"
state = "walking_in";

// Applicant data (will be set by controller)
applicant_data = {};
has_data = false;

// Loading timer
loading_timer = 0;
loading_duration = 60; // 5 seconds at 60fps

// Decision timer (60 seconds)
decision_timer = 0;
decision_duration = 3600; // 60 seconds at 60fps

// Decision result
decision = "none"; // "none", "accepted", "denied", "timeout"

// Speech bubble system
speech_index = 0;
showing_speech = false;
current_speech_text = "";
response_text = "";
showing_response = false;
response_timer = 0;
response_duration = 120;

// NEW: Pause before walking out
pause_before_exit = true;
pause_timer = 0;
pause_duration = 45; // 1 second pause at 60fps

// Attack system
is_attacker = false;
attack_detected = false;
attack_warning_visible = true;
attack_warning_blink_timer = 0;
attack_warning_blink_speed = 30;
attack_detonation_timer = 0;
attack_detonation_countdown = 600;
detained = false;

// Explosion state
explosion_timer = 0;
explosion_delay = 120;

// Temporary storage for cascading feedback
pending_feedback = [];

// NEW: Track when to offer items after resource feedback
item_offer_delay_timer = 0;
should_offer_item = false;
pending_item_offer = undefined;

/// @desc Execute bomb attack
function execute_attack() {
    show_debug_message("ATTACK EXECUTED!");
    
    // Random resource loss (5-15 each)
    var food_loss = irandom_range(5, 15);
    var water_loss = irandom_range(5, 15);
    var energy_loss = irandom_range(5, 15);
    var spirit_loss = irandom_range(5, 15);
    
    // Reduce attack damage if player has bluebird
    if (global.has_bluebird) {
        food_loss = floor(food_loss * 0.5);
        water_loss = floor(water_loss * 0.5);
        energy_loss = floor(energy_loss * 0.5);
        spirit_loss = floor(spirit_loss * 0.5);
        show_debug_message("Bluebird reduced attack damage!");
    }
    
    global.food = max(0, global.food - food_loss);
    global.water = max(0, global.water - water_loss);
    global.energy = max(0, global.energy - energy_loss);
    global.spirit = max(0, global.spirit - spirit_loss);
    
    // Log attack for report
    var attack_note = "SECURITY BREACH: Bomb attack in applicant queue. Resources lost: " +
                      string(food_loss) + " Food, " +
                      string(water_loss) + " Water, " +
                      string(energy_loss) + " Energy, " +
                      string(spirit_loss) + " Spirit.";
    array_push(global.current_month_notes, attack_note);
    
    // Visual effect (optional - screen shake, flash, etc.)
    // You can add this later with camera shake or screen effects
}

if (has_data && variable_struct_exists(applicant_data, "is_attacker")) {
    is_attacker = applicant_data.is_attacker;
}

/// @desc Execute bomb explosion with particle effect
function execute_attack_with_explosion() {
    show_debug_message("EXPLOSION!");
    
    // Hide speech bubble
    showing_speech = false;
    
    // Create white flash effect
    var flash = instance_create_depth(x, y, -200, obj_screen_flash);
    
    // Create explosion particles (fragments of the sprite)
    var particle_count = 20;
    for (var i = 0; i < particle_count; i++) {
        var particle = instance_create_depth(x, y, -100, obj_explosion_particle);
        particle.fragment_sprite = sprite_index;
        particle.fragment_subimage = 0;
        particle.scale = random_range(0.2, 0.5);
    }
    
    // Calculate resource loss
    var food_loss = irandom_range(5, 15);
    var water_loss = irandom_range(5, 15);
    var energy_loss = irandom_range(5, 15);
    var spirit_loss = irandom_range(5, 15);
    
    // Reduce if bluebird present
    if (global.has_bluebird) {
        food_loss = floor(food_loss * 0.5);
        water_loss = floor(water_loss * 0.5);
        energy_loss = floor(energy_loss * 0.5);
        spirit_loss = floor(spirit_loss * 0.5);
    }
    
    // Start smooth resource drain
    with (obj_resource_display) {
        start_resource_drain(food_loss, water_loss, energy_loss, spirit_loss);
    }
    
    // Log attack
    var attack_note = "SECURITY BREACH: Bomb attack. Resources lost: " +
                      string(food_loss) + " Food, " +
                      string(water_loss) + " Water, " +
                      string(energy_loss) + " Energy, " +
                      string(spirit_loss) + " Spirit.";
    array_push(global.current_month_notes, attack_note);
    
    // NEW: Properly finish this applicant (increments index and clears current)
    with (obj_applicant_controller) {
        applicant_finished("exploded", other.applicant_data);
    }
    
    // Destroy applicant
    instance_destroy();
}