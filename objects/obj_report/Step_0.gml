/// Step Event

// Hover effect and click (only when NOT centered and NOT animating)
if (!is_centered && !is_animating) {
    if (position_meeting(mouse_x, mouse_y, id)) {
        image_alpha = 0.6;
        
        if (mouse_check_button_pressed(mb_left)) {
            is_animating = true;
            is_centered = true;
        }
    } else {
        image_alpha = 1;
    }
} else if (is_centered && !is_animating) {
    // Click to return to fixed position
    if (mouse_check_button_pressed(mb_left)) {
        if (position_meeting(mouse_x, mouse_y, id)) {
            is_animating = true;
            is_centered = false;
        }
    }
    image_alpha = 1;
} else {
    image_alpha = 1;
}

// Animate position if needed
if (is_animating) {
    anim_progress += anim_speed;
    
    if (anim_progress >= 1) {
        anim_progress = 1;
        is_animating = false;
        
        // NEW: Detect state changes when animation completes
        if (is_centered) {
            // Just finished opening (animating TO center)
            has_new_report = false;
            global.must_read_report = false;
            
            show_debug_message("Report OPENED");
        } else {
            // Just finished closing (animating FROM center)
            with (obj_applicant_controller) {
                report_was_closed = true;
                spawn_delay_timer = 0;
            }
            
            show_debug_message("Report CLOSED - Starting spawn delay");
        }
    }
    
    var target_x, target_y, target_sx, target_sy, target_rot;
    var from_x, from_y, from_sx, from_sy, from_rot;
    
    if (is_centered) {
        from_x = fixed_x;
        from_y = fixed_y;
        from_sx = fixed_scale_x;
        from_sy = fixed_scale_y;
        from_rot = fixed_rotation;
        
        target_x = center_x;
        target_y = center_y;
        target_sx = center_scale_x;
        target_sy = center_scale_y;
        target_rot = center_rotation;
    } else {
        from_x = center_x;
        from_y = center_y;
        from_sx = center_scale_x;
        from_sy = center_scale_y;
        from_rot = center_rotation;
        
        target_x = fixed_x;
        target_y = fixed_y;
        target_sx = fixed_scale_x;
        target_sy = fixed_scale_y;
        target_rot = fixed_rotation;
    }
    
    x = lerp(from_x, target_x, anim_progress);
    y = lerp(from_y, target_y, anim_progress);
    image_xscale = lerp(from_sx, target_sx, anim_progress);
    image_yscale = lerp(from_sy, target_sy, anim_progress);
    image_angle = lerp(from_rot, target_rot, anim_progress);
    
    if (!is_animating) {
        anim_progress = 0;
    }
}

// Fade text in/out based on state
if (is_centered && !is_animating) {
    text_alpha = min(text_alpha + 0.05, 1);
} else {
    text_alpha = max(text_alpha - 0.1, 0);
}


// Blink indicator if new report
if (has_new_report && !is_centered) {
    indicator_blink_timer++;
    if (indicator_blink_timer >= indicator_blink_speed) {
        indicator_visible = !indicator_visible;
        indicator_blink_timer = 0;
    }
}