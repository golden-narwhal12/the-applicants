/// Step Event

switch(state) {
   case "walking_in":
    anim_progress += anim_speed;
    
    // Attack system
    if (is_attacker && !detained) {
        attack_detonation_timer++;
        
        var time_ratio = attack_detonation_timer / attack_detonation_countdown;
        attack_warning_blink_speed = lerp(30, 5, time_ratio);
        
        attack_warning_blink_timer++;
        if (attack_warning_blink_timer >= attack_warning_blink_speed) {
            attack_warning_visible = !attack_warning_visible;
            attack_warning_blink_timer = 0;
        }
        
        if (mouse_check_button_pressed(mb_left)) {
            if (position_meeting(mouse_x, mouse_y, id)) {
                detained = true;
                is_attacker = false;
                decision = "detained";
                state = "walking_out";
                anim_progress = 0;
                text_window_clear();
                show_debug_message("Attacker detained!");
            }
        }
        
        // NEW: Check if reached center (not detonation countdown)
        if (anim_progress >= 1) {
            // Reached center - prepare for explosion
            anim_progress = 1;
            state = "exploding";  // NEW STATE
            explosion_timer = 0;
            explosion_delay = 60;  // 1 second
            
            // Show final speech
            showing_speech = true;
            current_speech_text = "You should have let me in.";
            
            text_window_clear();
            return;  // Don't transition to loading
        }
    }
    
    if (anim_progress >= 1) {
        anim_progress = 1;
        state = "loading";
        loading_timer = 0;
        
        with (obj_text_window) {
            state = "loading";
            loading_timer = 0;
        }
    }
    
    x = lerp(start_x, center_x, anim_progress);
    y = lerp(start_y, center_y, anim_progress);
    image_xscale = lerp(0.5, 0.9, anim_progress);
    image_yscale = lerp(0.5, 0.9, anim_progress);
    
    var target_color = make_color_rgb(255, 204, 204);
    image_blend = merge_color(c_white, target_color, anim_progress);
    break;
        
    case "loading":
        // CRITICAL: Always increment timer (no blocking here)
        loading_timer++;
		
    // DEBUG - Remove after testing
    if (loading_timer == 1) {
        show_debug_message("Loading started. Duration: " + string(loading_duration));
    }
    if (loading_timer mod 10 == 0) {
        show_debug_message("Loading timer: " + string(loading_timer) + " / " + string(loading_duration));
    }
        
        // Start speech bubble during loading
        if (loading_timer == 1) {
            if (has_data && variable_struct_exists(applicant_data, "speech_lines")) {
                if (array_length(applicant_data.speech_lines) > 0) {
                    showing_speech = true;
                    speech_index = 0;
                    current_speech_text = applicant_data.speech_lines[0];
                }
            }
        }
        
        // Click to progress speech
        if (showing_speech && mouse_check_button_pressed(mb_left)) {
            if (position_meeting(mouse_x, mouse_y, id)) {
                speech_index++;
                
                if (speech_index < array_length(applicant_data.speech_lines)) {
                    current_speech_text = applicant_data.speech_lines[speech_index];
                } else {
                    showing_speech = false;
                }
            }
        }
        
		if (loading_timer >= loading_duration) {
		    show_debug_message("Loading complete! Switching to showing_profile");
		    state = "showing_profile";
		    decision_timer = 0;
    
		    // Start reveal system with biography sections
		    if (has_data && variable_struct_exists(applicant_data, "biography_sections")) {
		        var sections = applicant_data.biography_sections;
		        var free_preview = sections[0];
        
		        show_debug_message("Starting reveal with preview: " + free_preview);  // DEBUG
        
		        var reveal_sections = [];
		        for (var i = 1; i < array_length(sections); i++) {
		            array_push(reveal_sections, sections[i]);
		        }
        
		        show_debug_message("Reveal sections count: " + string(array_length(reveal_sections)));  // DEBUG
        
		        text_window_start_reveal(reveal_sections, free_preview);
        
		        show_debug_message("Reveal started successfully");  // DEBUG
		    } else {
		        show_debug_message("ERROR: No biography_sections found!");  // DEBUG
		    }
            
            if (has_data && variable_struct_exists(applicant_data, "speech_lines")) {
                if (speech_index < array_length(applicant_data.speech_lines)) {
                    showing_speech = true;
                }
            }
            
            if (has_data && variable_struct_exists(applicant_data, "gives_item_on_walk_up")) {
                var item = applicant_data.gives_item_on_walk_up;
                offer_item_to_player(item.item_id, item.item_name, item.item_description,
                                   item.sprite, applicant_data.id, item.abilities);
            }
        }
        break;
        
   case "showing_profile":
    // Block all actions if must read report
    if (global.must_read_report) {
        break;
    }
    
    decision_timer++;
    
    // Click to progress speech
    if (showing_speech && mouse_check_button_pressed(mb_left)) {
        if (position_meeting(mouse_x, mouse_y, id)) {
            speech_index++;
            
            if (speech_index < array_length(applicant_data.speech_lines)) {
                current_speech_text = applicant_data.speech_lines[speech_index];
            } else {
                showing_speech = false;
            }
        }
    }
    
    // Check for timeout
    if (decision_timer >= decision_duration) {
        decision = "timeout";
        state = "walking_out";
        anim_progress = 0;
        showing_speech = false;
        
        if (has_data && variable_struct_exists(applicant_data, "deny_response")) {
            response_text = applicant_data.deny_response;
        }
        
        text_window_clear();
        break;
    }
    
    // Check if report is open - block decisions
    var report_is_open = false;
    with (obj_report) {
        if (is_centered) {
            report_is_open = true;
        }
    }
    
    if (report_is_open) {
        break;
    }
    
    // Handle mouse clicks for accept/deny zones
    if (mouse_check_button_pressed(mb_left)) {
        // Only process if NOT clicking on the applicant themselves
        if (!position_meeting(mouse_x, mouse_y, id)) {
            
            // === DENY ZONE (LEFT SIDE) ===
            if (point_in_rectangle(mouse_x, mouse_y, 330, 0, 530, 430)) {
                decision = "denied";
                state = "walking_out";
                anim_progress = 0;
                showing_speech = false;
                
                // Check if should offer item on deny
                if (has_data && variable_struct_exists(applicant_data, "gives_item_on_deny")) {
                    should_offer_item = true;
                    pending_item_offer = applicant_data.gives_item_on_deny;
                    item_offer_delay_timer = -30;  // 0.5 seconds
                }
                
                if (has_data && variable_struct_exists(applicant_data, "deny_response")) {
                    response_text = applicant_data.deny_response;
                }
                
                text_window_clear();
                break;  // Exit case immediately
            }
            
            // === ACCEPT ZONE (RIGHT SIDE) ===
			if (point_in_rectangle(mouse_x, mouse_y, 1166, 0, 1366, 430)) {
			    decision = "accepted";
			    state = "walking_out";
			    anim_progress = 0;
			    showing_speech = false;
    
			    // Prepare cascading feedback
			    pending_feedback = [];
    
			    if (has_data) {
			        // Collect all resource changes
			        if (variable_struct_exists(applicant_data, "food_change") && applicant_data.food_change != 0) {
			            array_push(pending_feedback, {
			                text: (applicant_data.food_change > 0 ? "+" : "") + string(applicant_data.food_change) + " Food",
			                color: applicant_data.food_change > 0 ? c_lime : c_red
			            });
			            global.food += applicant_data.food_change;
			        }
        
			        if (variable_struct_exists(applicant_data, "water_change") && applicant_data.water_change != 0) {
			            array_push(pending_feedback, {
			                text: (applicant_data.water_change > 0 ? "+" : "") + string(applicant_data.water_change) + " Water",
			                color: applicant_data.water_change > 0 ? c_lime : c_red
			            });
			            global.water += applicant_data.water_change;
			        }
        
			        if (variable_struct_exists(applicant_data, "energy_change") && applicant_data.energy_change != 0) {
			            array_push(pending_feedback, {
			                text: (applicant_data.energy_change > 0 ? "+" : "") + string(applicant_data.energy_change) + " Energy",
			                color: applicant_data.energy_change > 0 ? c_lime : c_red
			            });
			            global.energy += applicant_data.energy_change;
			        }
        
			        if (variable_struct_exists(applicant_data, "spirit_change") && applicant_data.spirit_change != 0) {
			            array_push(pending_feedback, {
			                text: (applicant_data.spirit_change > 0 ? "+" : "") + string(applicant_data.spirit_change) + " Spirit",
			                color: applicant_data.spirit_change > 0 ? c_lime : c_red
			            });
			            global.spirit += applicant_data.spirit_change;
			        }
        
			        // Clamp resources
			        global.food = clamp(global.food, 0, global.max_food);
			        global.water = clamp(global.water, 0, global.max_water);
			        global.energy = clamp(global.energy, 0, global.max_energy);
			        global.spirit = clamp(global.spirit, 0, global.max_spirit);
        
			        // NEW: Check lose condition after resource changes
			        if (check_lose_condition()) {
			            // Game over triggered, exit immediately
			            instance_destroy();
			            return;
			        }
			    }

                
                // Trigger cascading spawn using alarms
                if (array_length(pending_feedback) > 0) {
                    alarm[0] = 1;  // Start immediately
                }
                
                // Check if should offer item on accept
                if (has_data && variable_struct_exists(applicant_data, "gives_item_on_accept")) {
                    should_offer_item = true;
                    pending_item_offer = applicant_data.gives_item_on_accept;
                    
                    // Calculate delay: last feedback spawns at 1 + (count-1)*18
                    // Then add 30 frames (0.5s) after that
                    var feedback_count = array_length(pending_feedback);
                    if (feedback_count > 0) {
                        item_offer_delay_timer = -(1 + (feedback_count - 1) * 18 + 30);
                    } else {
                        item_offer_delay_timer = -30;  // Just 0.5s if no feedback
                    }
                }
                
                if (has_data && variable_struct_exists(applicant_data, "accept_response")) {
                    response_text = applicant_data.accept_response;
                }
                
                text_window_clear();
                break;  // Exit case immediately
            }
        }
    }
    break;  // End of showing_profile case
	
	case "exploding":
    explosion_timer++;
    
    // Hide speech bubble after 0.5 seconds
    if (explosion_timer >= 30) {
        showing_speech = false;
    }
    
    // Explode after 1 second
    if (explosion_timer >= explosion_delay) {
        execute_attack_with_explosion();
    }
    break;
        
    case "walking_out":
    // NEW: Handle delayed item offering
    if (should_offer_item) {
        item_offer_delay_timer++;
        
        if (item_offer_delay_timer >= 0) {
            // Time to offer item
            var item = pending_item_offer;
            offer_item_to_player(item.item_id, item.item_name, item.item_description,
                               item.sprite, applicant_data.id, item.abilities);
            
            should_offer_item = false;
            pending_item_offer = undefined;
        }
    }
    
    if (pause_before_exit) {
        pause_timer++;
        
        if (!showing_response && response_text != "") {
            showing_response = true;
            response_timer = 0;
        }
        
        if (showing_response) {
            response_timer++;
        }
        
        if (pause_timer >= pause_duration) {
            pause_before_exit = false;
        }
        
        break;
    }
    
    if (showing_response) {
        response_timer++;
        if (response_timer >= response_duration + pause_duration) {
            showing_response = false;
        }
    }
    
    anim_progress += anim_speed;
    
    if (anim_progress >= 1) {
        anim_progress = 1;
        with (obj_applicant_controller) {
            applicant_finished(other.decision, other.applicant_data);
        }
        instance_destroy();
    }
    
    if (decision == "accepted") {
        x = lerp(center_x, exit_x_accepted, anim_progress);
        y = lerp(center_y, exit_y_accepted, anim_progress);
    } else {
        x = lerp(center_x, exit_x_denied, anim_progress);
        y = lerp(center_y, exit_y_denied, anim_progress);
    }
    
    image_xscale = lerp(0.9, 0.5, anim_progress);
    image_yscale = lerp(0.9, 0.5, anim_progress);
    
    var target_color = make_color_rgb(255, 204, 204);
    image_blend = merge_color(target_color, c_white, anim_progress);
    break;
}