/// @desc Start the applicant queue
/// @param num_applicants (-1 for infinite)

function start_applicant_queue(_num) {
    with (obj_applicant_controller) {
        total_applicants = _num;
        applicants_spawned = 0;
        spawn_timer = 0;
        queue_active = true;
        current_applicant = noone;
        applicant_left = false;
    }
}

/// @desc Stop the applicant queue
function stop_applicant_queue() {
    with (obj_applicant_controller) {
        queue_active = false;
    }
}

/// @desc Send current applicant away immediately
function dismiss_current_applicant() {
    with (obj_applicant_controller) {
        if (current_applicant != noone && instance_exists(current_applicant)) {
            with (current_applicant) {
                if (state == "at_center") {
                    state = "walking_out";
                    anim_progress = 0;
                }
            }
        }
    }
}

/// @desc Change how long applicants stay at center
/// @param frames
function set_applicant_center_duration(_frames) {
    with (obj_applicant) {
        center_duration = _frames;
    }
}