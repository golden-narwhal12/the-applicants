/// Step Event

if (global.must_read_report) {
    return;
}

if (show_offer) {
    fade_alpha = min(fade_alpha + fade_speed, 1);
} else {
    fade_alpha = max(fade_alpha - fade_speed * 2, 0);
}