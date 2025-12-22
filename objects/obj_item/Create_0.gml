/// Create Event

// Item data
item_id = "";
item_name = "";
item_description = "";
item_sprite = -1;
item_quantity = 1;
given_by_applicant = "";

// Target display size
target_size = 128;  

// Dragging
is_dragging = false;
drag_offset_x = 0;
drag_offset_y = 0;

// Context menu
showing_context_menu = false;
context_menu_x = 0;
context_menu_y = 0;

// Bounds (item space: x=0-319, y=276-768)
min_x = 0;
max_x = 319;
min_y = 276;
max_y = 768;

// Tooltip
showing_tooltip = false;

// Special abilities
abilities = [];

depth = -50;

/// @desc Give item to current applicant
function give_item_to_applicant() {
    with (obj_applicant) {
        if (state == "showing_profile") {
            var item_given = other.item_id;
            var correct_item = false;
            
            // Check if this applicant wants this item
            if (variable_struct_exists(applicant_data, "requested_item")) {
                if (applicant_data.requested_item == item_given) {
                    // Correct item!
                    correct_item = true;
                    
                    // Custom response for correct item
                    if (variable_struct_exists(applicant_data, "item_received_response")) {
                        current_speech_text = applicant_data.item_received_response;
                        showing_speech = true;
                    } else {
                        current_speech_text = "Thank you. This means everything.";
                        showing_speech = true;
                    }
                    
                    // Apply rewards
                    if (variable_struct_exists(applicant_data, "item_reward")) {
                        var reward = applicant_data.item_reward;
                        if (variable_struct_exists(reward, "food")) global.food += reward.food;
                        if (variable_struct_exists(reward, "water")) global.water += reward.water;
                        if (variable_struct_exists(reward, "energy")) global.energy += reward.energy;
                        if (variable_struct_exists(reward, "spirit")) global.spirit += reward.spirit;
                        
                        // Clamp resources
                        global.food = clamp(global.food, 0, global.max_food);
                        global.water = clamp(global.water, 0, global.max_water);
                        global.energy = clamp(global.energy, 0, global.max_energy);
                        global.spirit = clamp(global.spirit, 0, global.max_spirit);
                    }
                    
                    // Reduce desperation significantly
                    if (variable_struct_exists(applicant_data, "desperation_level")) {
                        applicant_data.desperation_level = max(0, applicant_data.desperation_level - 3);
                    }
                }
            }
            
            // Wrong item or unsolicited gift
            if (!correct_item) {
                // Random response from preset batch
                var responses = [
                    "Oh... thank you, I guess.",
                    "I appreciate it.",
                    "That's... kind of you.",
                    "Thanks. Not sure what I'll do with this.",
                    "I'll take it. Every bit helps.",
                    "This is unexpected. Thank you.",
                    "I wasn't expecting charity, but... thanks."
                ];
                
                var random_response = responses[irandom(array_length(responses) - 1)];
                current_speech_text = random_response;
                showing_speech = true;
                
                // Small chance to reduce desperation
                if (random(1) < 0.5) {  // 50% chance
                    if (variable_struct_exists(applicant_data, "desperation_level")) {
                        applicant_data.desperation_level = max(0, applicant_data.desperation_level - 1);
                    }
                }
            }
        }
    }
    
    // Remove item from inventory
    discard_item();
}

/// @desc Give item to community
function give_item_to_community() {
    var feedback_text = "";
    var item_x = x;
    var item_y = y;
    
    // Apply item's community effect
    if (item_id == "bluebird") {
        global.spirit += 5;
        global.has_bluebird = false;
        feedback_text = "+5 Spirit";
    }
    else if (item_id == "bread") {
        var gain = 2 * item_quantity;
        global.food += gain;
        feedback_text = "+" + string(gain) + " Food";
    }
    else if (item_id == "water_bottle") {
        var gain = 2 * item_quantity;
        global.water += gain;
        feedback_text = "+" + string(gain) + " Water";
    }
    else if (item_id == "medicine") {
        global.spirit += 3;
        feedback_text = "+3 Spirit";
    }
    else if (item_id == "seeds") {
        global.food += 4 * item_quantity;
        feedback_text = "+" + string(4 * item_quantity) + " Food";
    }
    else if (item_id == "photo") {
        global.spirit += 2;
        feedback_text = "+2 Spirit";
    }
    else if (item_id == "tools") {
        global.energy += 3;
        feedback_text = "+3 Energy";
    }
    else {
        // Default: small spirit boost
        global.spirit += 1;
        feedback_text = "+1 Spirit";
    }
    
    // Clamp resources
    global.food = clamp(global.food, 0, global.max_food);
    global.water = clamp(global.water, 0, global.max_water);
    global.energy = clamp(global.energy, 0, global.max_energy);
    global.spirit = clamp(global.spirit, 0, global.max_spirit);
    
    // Create feedback text at item position
    var feedback = instance_create_depth(item_x, item_y, -100, obj_donation_feedback);
    feedback.feedback_text = feedback_text;
    
    // Remove item
    discard_item();
}

/// @desc Remove item from game
function discard_item() {
    // Remove from global inventory
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i].item_id == item_id) {
            array_delete(global.inventory, i, 1);
            break;
        }
    }
    
    // Destroy this item instance
    instance_destroy();
}