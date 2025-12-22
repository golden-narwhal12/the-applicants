/// Create Event

month_text = "Month 1";
alpha = 0;
timer = 0;

// NEW: Extended to match transition - 3.25 seconds total
fade_in_duration = 30;   // 0.5 seconds
hold_duration = 60;     // 2.25 seconds (was 90)
fade_out_duration = 30;  // 0.5 seconds
total_duration = fade_in_duration + hold_duration + fade_out_duration;  // 195 total

depth = -10000;
persistent = false;