/// @desc Get report text for a specific month
/// @param month_number

/// @desc Modify resource values safely
/// @param resource_name ("food", "water", "energy", or "spirit")
/// @param amount (can be negative)

function modify_resource(_resource, _amount) {
    switch(_resource) {
        case "food":
            global.food = clamp(global.food + _amount, 0, global.max_food);
            break;
        case "water":
            global.water = clamp(global.water + _amount, 0, global.max_water);
            break;
        case "energy":  // NEW
            global.energy = clamp(global.energy + _amount, 0, global.max_energy);
            break;
        case "spirit":
            global.spirit = clamp(global.spirit + _amount, 0, global.max_spirit);
            break;
    }
}

/// @desc Get resource value
/// @param resource_name
function get_resource(_resource) {
    switch(_resource) {
        case "food": return global.food;
        case "water": return global.water;
        case "energy": return global.energy;  // NEW
        case "spirit": return global.spirit;
        default: return 0;
    }
}

/// @desc Get report text for a given month
/// @param month (optional, defaults to current month)

function get_report_text(_month = global.current_month) {
    var lines = [];
    
    // Month 1: Tutorial briefing
    if (_month == 1) {
        array_push(lines, "=== MONTH 1 REPORT ===");
        array_push(lines, "");
        array_push(lines, "Welcome to your new job! You must screen applicants for entry to the colony.");
        array_push(lines, "");
        array_push(lines, "Resources are scarce. Every person accepted consumes food, water, and energy. Some contribute more than they take. Most don't.");
        array_push(lines, "");
        array_push(lines, "Applicants will claim anything to get in. They'll give you items, guilt trip you. But you can't trust anybody. That's why we've built an advanced AI system that uses their browsing history to summarize their profile. The problem is - we don't have enough energy to investigate everyone fully.");
        array_push(lines, "");
        array_push(lines, "Make your choices. Live with the consequences.");
        array_push(lines, "");
        array_push(lines, "Colony status reports will be delivered monthly.");
        array_push(lines, "");
        array_push(lines, "--- END BRIEFING ---");
        return lines;
    }
    
    // Month 2+: Show outcomes from previous month
    array_push(lines, "=== MONTH " + string(_month) + " REPORT ===");
    array_push(lines, "");
    
    // Show previous month's outcomes
    array_push(lines, "MONTH " + string(_month - 1) + " OUTCOMES:");
    array_push(lines, "");
    
    // Add decision notes from previous month
    if (array_length(global.current_month_notes) > 0) {
        for (var i = 0; i < array_length(global.current_month_notes); i++) {
            array_push(lines, global.current_month_notes[i]);
            array_push(lines, "");
        }
    } else {
        array_push(lines, "No significant incidents this month.");
        array_push(lines, "");
    }
    
    // Current resource status
    array_push(lines, "CURRENT RESOURCES:");
    array_push(lines, "Food: " + string(global.food) + "/" + string(global.max_food));
    array_push(lines, "Water: " + string(global.water) + "/" + string(global.max_water));
    array_push(lines, "Energy: " + string(global.energy) + "/" + string(global.max_energy));
    array_push(lines, "Spirit: " + string(global.spirit) + "/" + string(global.max_spirit));
    array_push(lines, "");
    
    // Status assessment
    var total = global.food + global.water + global.energy + global.spirit;
    if (total > 140) {
        array_push(lines, "STATUS: Colony thriving.");
    } else if (total > 100) {
        array_push(lines, "STATUS: Colony stable.");
    } else if (total > 60) {
        array_push(lines, "STATUS: Colony declining. Action needed.");
    } else {
        array_push(lines, "STATUS: CRITICAL. Survival at risk.");
    }
    array_push(lines, "");
    
    array_push(lines, "--- END REPORT ---");
    
    return lines;
}

/// @desc Update report to show current month's text
function update_report_text() {
    with (obj_report) {
        text_lines = get_report_text(global.current_month);
    }
}

/// @desc Advance to next month and update report
function advance_to_next_month() {
    global.current_month++;
    if (global.current_month > global.max_month) {
        global.current_month = global.max_month; // Cap at max month
    }
    update_report_text();
}

/// @desc Set specific month
/// @param month_number
function set_month(_month) {
    global.current_month = clamp(_month, 1, global.max_month);
    update_report_text();
}

