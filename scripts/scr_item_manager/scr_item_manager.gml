/// @desc Offer item to player (with accept/deny prompt)
/// @param item_id
/// @param item_name
/// @param item_description
/// @param sprite
/// @param given_by
/// @param abilities_array

function offer_item_to_player(_id, _name, _desc, _sprite, _given_by, _abilities = []) {
    // Store pending item offer
    global.pending_item_offer = {
        item_id: _id,
        item_name: _name,
        item_description: _desc,
        sprite: _sprite,
        given_by: _given_by,
        abilities: _abilities
    };
    
    // Trigger item offer UI
    with (obj_item_offer_ui) {
        show_offer = true;
        fade_alpha = 0;  // Start fade from 0
    }
}

function add_item_to_inventory(_id, _name, _desc, _sprite, _given_by, _abilities = []) {
    // Check if item already exists (for stacking)
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i].item_id == _id) {
            // Item exists, increase quantity
            global.inventory[i].quantity++;
            
            // Update existing instance
            with (obj_item) {
                if (item_id == _id) {
                    item_quantity++;
                }
            }
            return true;
        }
    }
    
    // Check inventory limit (6 unique items)
    if (array_length(global.inventory) >= 6) {
        return false;  // Inventory full
    }
    
    // Add new item to global inventory
    var item_data = {
        item_id: _id,
        item_name: _name,
        item_description: _desc,
        sprite: _sprite,
        given_by: _given_by,
        abilities: _abilities,
        quantity: 1
    };
    array_push(global.inventory, item_data);
    
    // NEW: Find a non-overlapping position for the item
    var spawn_x = 160;
    var spawn_y = 400;
    var attempt = 0;
    var max_attempts = 20;
    var spacing = 80;  // Minimum spacing between items
    
    // Try to find empty position
    while (attempt < max_attempts) {
        var position_clear = true;
        
        // Check if any existing item is too close
        with (obj_item) {
            if (point_distance(spawn_x, spawn_y, x, y) < spacing) {
                position_clear = false;
            }
        }
        
        if (position_clear) {
            break;  // Found good position
        }
        
        // Try new position
        attempt++;
        spawn_x = random_range(80, 240);
        spawn_y = random_range(320, 700);
    }
    
    // Create item instance at non-overlapping position
    var item = instance_create_depth(spawn_x, spawn_y, -50, obj_item);
    with (item) {
        item_id = _id;
        item_name = _name;
        item_description = _desc;
        item_sprite = _sprite;
        given_by_applicant = _given_by;
        abilities = _abilities;
        item_quantity = 1;
    }
    
    // Apply special abilities
    if (array_contains(_abilities, "reduce_attack_chance")) {
        global.has_bluebird = true;
    }
    
    return true;
}