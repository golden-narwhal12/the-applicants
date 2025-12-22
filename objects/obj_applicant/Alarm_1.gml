/// Alarm 1 Event

if (array_length(pending_feedback) > 0) {
    var feedback_data = pending_feedback[0];
    
    var feedback = instance_create_depth(center_x, center_y - 100, -150, obj_resource_feedback);
    feedback.feedback_text = feedback_data.text;
    feedback.text_color = feedback_data.color;
    
    array_delete(pending_feedback, 0, 1);
    
    if (array_length(pending_feedback) > 0) {
        alarm[2] = 18;
    }
}