/// Step Event

timer++;

if (timer <= fade_in_duration) {
    // Fade in
    alpha = timer / fade_in_duration;
} else if (timer <= fade_in_duration + hold_duration) {
    // Hold
    alpha = 1;
} else if (timer <= total_duration) {
    // Fade out
    var fade_progress = (timer - fade_in_duration - hold_duration) / fade_out_duration;
    alpha = 1 - fade_progress;
} else {
    // Done
    instance_destroy();
}