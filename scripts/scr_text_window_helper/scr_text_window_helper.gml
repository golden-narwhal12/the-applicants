/// @desc Set text in the window
/// @param text
function text_window_set_text(_text) {
    with (obj_text_window) {
        text_content = _text;
        scroll_offset = 0;
        state = "showing_text";
    }
}

/// @desc Clear the window
function text_window_clear() {
    with (obj_text_window) {
        text_content = "";
        scroll_offset = 0;
        state = "idle";
    }
}

/// @desc Start loading animation
function text_window_start_loading() {
    with (obj_text_window) {
        state = "loading";
        loading_timer = 0;
        loading_phrase_timer = 0;
        loading_phrase_index = 0;
        text_content = loading_phrases[0];
    }
}

/// @desc Start biography reveal mode
/// @param sections_array - Array of text sections to reveal
/// @param free_preview - Text shown for free
function text_window_start_reveal(_sections, _preview) {
    with (obj_text_window) {
        // Set state (not mode!)
        state = "showing_text";
        
        // Store reveal data
        reveal_mode = true;
        free_preview_text = _preview;
        revealed_sections = [];
        reveal_sections = _sections;
        current_reveal_index = 0;
        show_reveal_button = (array_length(_sections) > 0);
        reveals_this_applicant = 0;
        
        // CRITICAL: Actually set the text content to the preview
        text_content = _preview;
        scroll_offset = 0;
        
        show_debug_message("Reveal mode started. State: " + state);
        show_debug_message("Preview: " + _preview);
        show_debug_message("Sections to reveal: " + string(array_length(_sections)));
    }
}

/// @desc Update text display with revealed sections
function update_revealed_text() {
    with (obj_text_window) {
        // Start with free preview
        var full_text = free_preview_text;
        
        // Append all revealed sections
        for (var i = 0; i < array_length(revealed_sections); i++) {
            full_text += "\n\n" + revealed_sections[i];
        }
        
        text_content = full_text;
        scroll_offset = 0;
        
        show_debug_message("Text updated. Length: " + string(string_length(text_content)));
    }
}

/// @desc End reveal mode
function text_window_end_reveal() {
    with (obj_text_window) {
        reveal_mode = false;
        show_reveal_button = false;
        reveal_sections = [];
        current_reveal_index = 0;
        revealed_sections = [];
    }
}