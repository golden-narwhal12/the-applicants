/// Create Event

visible_text = "";  // NEW: Track text with reveals

// Window position and size
window_x = 320;
window_y = 460;
window_width = room_width - 320; // Takes up right side of screen
window_height = room_height - 460; // Takes up bottom portion

// Padding
text_padding = 20; // Padding on all sides

// Text settings
text_content = ""; // The actual text to display
text_color = c_white;
text_font = -1; // Set to your font, or -1 for default
line_height = 20; // Space between lines

// Background
bg_color = c_white;
bg_alpha = 0.9;
border_color = c_dkgray;
border_width = 2;

// Scrolling
scroll_offset = 0; // Current scroll position
max_scroll = 0; // Maximum scroll (calculated based on text height)
scroll_speed = 20; // Pixels to scroll per mouse wheel tick

// Text surface for rendering
text_surface = -1;
text_height = 0; // Total height of rendered text

// Mouse scroll detection
mouse_over = false;

// Glitch settings
glitch_enabled = true; // Set to false to disable glitching
glitch_time = 0;

// Loading animation
state = "idle"; // "idle", "loading", "showing_text"
loading_timer = 0;
loading_phrases = [
    "Establishing secure connection",
    "Accessing central database",
    "Gathering applicant data",
    "Verifying credentials",
    "Contacting background servers",
    "Loading profile",
	"Reaching conclusions",
    "Finalizing"
];
loading_phrase_index = 0;
loading_phrase_timer = 0;
loading_phrase_duration = 10; // frames per phrase

// Biography reveal system
reveal_mode = false;
reveal_sections = [];
current_reveal_index = 0;
revealed_sections = [];
show_reveal_button = false;
reveal_button_x = 0;
reveal_button_y = 0;
reveal_button_width = 220;  // Updated size
reveal_button_height = 35;  // Updated size
free_preview_text = "";  // NEW: Store preview separately
reveals_this_applicant = 0;
current_reveal_cost = 1;

/// @desc Start the reveal system
function text_window_start_reveal(_reveal_sections, _preview_text) {
    show_debug_message("text_window_start_reveal called");
    show_debug_message("Preview: " + _preview_text);
    show_debug_message("Reveal sections: " + string(array_length(_reveal_sections)));
    
    // Store reveal data
    reveal_sections = _reveal_sections;
    revealed_sections = [];
    free_preview_text = _preview_text;
    current_reveal_index = 0;
    reveals_this_applicant = 0;
    
    // Set initial text to preview only
    text_content = _preview_text;  // CHANGED: Set text_content, not visible_text
    
    // Enable reveal mode
    reveal_mode = true;
    show_reveal_button = (array_length(_reveal_sections) > 0);
    
    // Change state from "loading" to "showing_text"
    state = "showing_text";
    
    // Reset scroll
    scroll_offset = 0;
    
    show_debug_message("State changed to: " + state);
    show_debug_message("Reveal button visible: " + string(show_reveal_button));
}

/// @desc Update text with all revealed sections
function update_revealed_text() {
    // Start with preview
    text_content = free_preview_text;
    
    // Add all revealed sections
    for (var i = 0; i < array_length(revealed_sections); i++) {
        text_content += "\n\n" + revealed_sections[i];
    }
    
    // Reset scroll to top
    scroll_offset = 0;
    
    show_debug_message("Updated text, length: " + string(string_length(text_content)));
}