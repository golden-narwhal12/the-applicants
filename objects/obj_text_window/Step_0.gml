/// Step Event

// DEBUG - Remove after testing
if (keyboard_check_pressed(ord("T"))) {
    show_debug_message("=== TEXT WINDOW DEBUG ===");
    show_debug_message("State: " + state);
    show_debug_message("Reveal mode: " + string(reveal_mode));
    show_debug_message("Text content length: " + string(string_length(text_content)));
    show_debug_message("Show reveal button: " + string(show_reveal_button));
    show_debug_message("Text content: " + text_content);
}

// Handle loading animation
if (state == "loading") {
    loading_timer++;
    loading_phrase_timer++;
    
    // Cycle through phrases
    if (loading_phrase_timer >= loading_phrase_duration) {
        loading_phrase_timer = 0;
        loading_phrase_index++;
        
        if (loading_phrase_index >= array_length(loading_phrases)) {
            loading_phrase_index = 0; // Loop phrases
        }
        
        // Update displayed text
        text_content = loading_phrases[loading_phrase_index];
    }
    
    // Check if loading is done (will be controlled by applicant)
    // The applicant will set state back to "idle" when ready
}

// Mouse interaction (only when showing text, not loading)
if (state == "showing_text" || state == "idle") {
    mouse_over = point_in_rectangle(mouse_x, mouse_y, window_x, window_y, 
                                     window_x + window_width, window_y + window_height);
    
    // Handle scrolling
    if (mouse_over) {
        var wheel = mouse_wheel_down() - mouse_wheel_up();
        scroll_offset += wheel * scroll_speed;
        scroll_offset = clamp(scroll_offset, 0, max_scroll);
    }
    
    // Keyboard scrolling
    if (mouse_over) {
        if (keyboard_check(vk_down)) {
            scroll_offset += scroll_speed * 0.5;
        }
        if (keyboard_check(vk_up)) {
            scroll_offset -= scroll_speed * 0.5;
        }
        scroll_offset = clamp(scroll_offset, 0, max_scroll);
    }
}

// Update glitch time
if (glitch_enabled) {
    glitch_time += delta_time / 100000;
}

// Handle reveal button clicks
if (reveal_mode && show_reveal_button) {
    if (mouse_check_button_pressed(mb_left)) {
        if (point_in_rectangle(mouse_x, mouse_y, reveal_button_x, reveal_button_y,
                               reveal_button_x + reveal_button_width, 
                               reveal_button_y + reveal_button_height)) {
            // Calculate escalating cost
            current_reveal_cost = reveals_this_applicant + 1;
            if (global.energy >= current_reveal_cost) {
                global.energy -= current_reveal_cost;
                reveals_this_applicant++;
                
                // NEW: Check lose condition after spending energy
                if (check_lose_condition()) {
                    exit;  // Exit if game over
                }
                
                // Reveal next section
                if (current_reveal_index < array_length(reveal_sections)) {
                    array_push(revealed_sections, reveal_sections[current_reveal_index]);
                    current_reveal_index++;
                    
                    // Update displayed text
                    update_revealed_text();
                    
                    // Check if all sections revealed
                    if (current_reveal_index >= array_length(reveal_sections)) {
                        show_reveal_button = false;
                        reveal_mode = false;
                    }
                }
            } else {
                // Not enough energy
                show_debug_message("Not enough energy!");
            }
        }
    }
}