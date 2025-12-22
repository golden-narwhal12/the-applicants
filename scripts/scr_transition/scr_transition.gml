/// @desc Transition to a room with fade effect
/// @param room_to_go_to

function transition_to_room(_room) {
    with (obj_transition) {
        target_room = _room;
        fade_state = "out";
        fade_alpha = 0;
        fade_timer = 0;
    }
}

/// @desc Change fade color
/// @param color

function transition_set_color(_color) {
    if (!instance_exists(obj_transition)) {
        instance_create_depth(0, 0, -9999, obj_transition);
    }
    
    with (obj_transition) {
        fade_color = _color;
    }
}

/// @desc Change fade speed
/// @param speed

function transition_set_speed(_speed) {
    if (!instance_exists(obj_transition)) {
        instance_create_depth(0, 0, -9999, obj_transition);
    }
    
    with (obj_transition) {
        fade_speed = _speed;
    }
}