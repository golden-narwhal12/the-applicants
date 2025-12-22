/// Create Event

// Current month data
current_month_data = {
    month: 0,
    applicants: []
};

// Spawn settings
spawn_delay = 30;  // Frames between applicants
spawn_timer = 0;

// Current state
current_applicant_index = 0;
current_applicant = noone;
decisions_this_month = [];
month_in_progress = false;

// Attack tracking
attacks_this_month = 0;
required_attacks_this_month = 0;

// NEW: Waiting for report flag
waiting_for_report_read = false;

// NEW: Report close delay
report_was_closed = false;
spawn_delay_timer = 0;
spawn_delay_duration = 60;  // 1 second at 60fps

// Functions
function start_month(_month) {
    global.current_month = _month;
    current_month_data = get_month_applicants(_month);
    current_applicant_index = 0;
    decisions_this_month = [];
    month_in_progress = true;
    spawn_timer = spawn_delay;
    
    // Determine required attacks
    switch(_month) {
        case 2:
            required_attacks_this_month = 1;
            break;
        case 3:
            required_attacks_this_month = 2;
            break;
        default:
            required_attacks_this_month = 0;
            break;
    }
    attacks_this_month = 0;
    
    // Inject attackers
    inject_attackers();
    
    // Show month transition only for month 2+ (month 1 handled by title screen)
    // BUT: Don't show it when called from room creation code
    // We'll let Alarm 0 handle the transition creation instead
    
    // Set report as unread
    with (obj_report) {
        has_new_report = true;
        indicator_visible = true;
        indicator_blink_timer = 0;
    }
    
    // Block spawning until report is read
    waiting_for_report_read = true;
    global.must_read_report = true;
    
    // DEBUG
    show_debug_message("=== MONTH " + string(_month) + " STARTED ===");
    show_debug_message("Total applicants: " + string(array_length(current_month_data.applicants)));
}

function spawn_next_applicant() {
    // DEBUG
    show_debug_message("=== SPAWNING APPLICANT ===");
    show_debug_message("Current index: " + string(current_applicant_index));
    show_debug_message("Total applicants: " + string(array_length(current_month_data.applicants)));
    
    if (current_applicant_index >= array_length(current_month_data.applicants)) {
        month_complete();
        return;
    }
    
    // Get applicant data from array
    var app_data = current_month_data.applicants[current_applicant_index];
    
    // DEBUG - Check data structure
    show_debug_message("Applicant ID: " + (variable_struct_exists(app_data, "id") ? app_data.id : "NO ID"));
    show_debug_message("Has biography_sections: " + string(variable_struct_exists(app_data, "biography_sections")));
    if (variable_struct_exists(app_data, "biography_sections")) {
        show_debug_message("Biography sections count: " + string(array_length(app_data.biography_sections)));
    }
    
    // Create applicant
    current_applicant = instance_create_depth(0, 0, 250, obj_applicant);
    
    with (current_applicant) {
        // Set custom sprite if available
        if (variable_struct_exists(app_data, "sprite")) {
            if (sprite_exists(app_data.sprite)) {
                sprite_index = app_data.sprite;
            } else {
                sprite_index = spr_applicant_general;
            }
        } else {
            sprite_index = spr_applicant_general;
        }
        
        // Recalculate positions based on sprite size
        var start_scale = 0.5;
        var half_width = (sprite_get_width(sprite_index) * start_scale) / 2;
        var half_height = (sprite_get_height(sprite_index) * start_scale) / 2;
        
        start_x = 320 + half_width + 15;
        start_y = 450 - half_height;
        center_x = 833;
        center_y = 275;
        exit_x_accepted = 1366 + 200;
        exit_y_accepted = 452 - half_height;
        exit_x_denied = start_x;
        exit_y_denied = start_y;
        
        x = start_x;
        y = start_y;
        
        // CRITICAL: Set applicant data
        applicant_data = app_data;
        has_data = true;
        
        // Check if attacker
        if (variable_struct_exists(app_data, "is_attacker")) {
            is_attacker = app_data.is_attacker;
        }
        
        // DEBUG
        show_debug_message("Applicant instance created with data");
    }
}

function applicant_finished(_decision, _data) {
    // Store decision
    var decision_record = {
        applicant_id: variable_struct_exists(_data, "id") ? _data.id : "unknown",
        decision: _decision,
        data: _data
    };
    array_push(decisions_this_month, decision_record);
    
    // Track denied applicants for potential attacks
    if (_decision == "denied" || _decision == "timeout") {
        if (variable_struct_exists(_data, "can_return_with_bomb")) {
            if (_data.can_return_with_bomb) {
                var applicant_name = variable_struct_exists(_data, "id") ? _data.id : "unknown";
                if (variable_struct_exists(_data, "biography_sections")) {
                    applicant_name = _data.biography_sections[0];
                }
                
                array_push(global.denied_applicants, {
                    id: variable_struct_exists(_data, "id") ? _data.id : "unknown",
                    name: applicant_name,
                    month_denied: global.current_month,
                    desperation_level: variable_struct_exists(_data, "desperation_level") ? 
                                      _data.desperation_level : 5
                });
            }
        }
    }
    
    // Move to next applicant
    current_applicant_index++;
    current_applicant = noone;
    spawn_timer = 0;
}

function month_complete() {
    month_in_progress = false;
    
    // Generate report notes
    global.current_month_notes = [];
    
    for (var i = 0; i < array_length(decisions_this_month); i++) {
        var decision_record = decisions_this_month[i];
        var data = decision_record.data;
        
        if (decision_record.decision == "accepted") {
            if (variable_struct_exists(data, "report_note_accepted")) {
                if (data.report_note_accepted != "") {
                    array_push(global.current_month_notes, data.report_note_accepted);
                }
            }
        } else if (decision_record.decision == "denied" || decision_record.decision == "timeout") {
            if (variable_struct_exists(data, "report_note_denied")) {
                if (data.report_note_denied != "") {
                    array_push(global.current_month_notes, data.report_note_denied);
                }
            }
        }
    }
    
    // Update report display
    with (obj_report) {
        text_lines = get_report_text(global.current_month);
        has_new_report = true;
    }
    
    // Auto-advance to next month after delay
    alarm[0] = 180;
}

function inject_attackers() {
    if (required_attacks_this_month <= 0) return;
    if (array_length(global.denied_applicants) == 0) return;
    
    var attackers_to_inject = min(required_attacks_this_month, 
                                 array_length(global.denied_applicants));
    
    for (var i = 0; i < attackers_to_inject; i++) {
        var denied_idx = irandom(array_length(global.denied_applicants) - 1);
        var attacker_data = global.denied_applicants[denied_idx];
        
        var attacker = {
            id: attacker_data.id + "_attacker",
            sprite: spr_applicant_general,
            biography_sections: [
                "RETURNING APPLICANT - PREVIOUSLY DENIED",
                "Detection systems indicate anomaly..."
            ],
            food_change: 0,
            water_change: 0,
            energy_change: 0,
            spirit_change: 0,
            report_note_accepted: "",
            report_note_denied: "",
            speech_lines: ["You denied me.", "Now you'll pay."],
            accept_response: "...",
            deny_response: "...",
            is_attacker: true,
            can_return_with_bomb: false,
            desperation_level: 10
        };
        
        var insert_pos = irandom(array_length(current_month_data.applicants) - 1);
        array_insert(current_month_data.applicants, insert_pos, attacker);
        
        array_delete(global.denied_applicants, denied_idx, 1);
    }
}
