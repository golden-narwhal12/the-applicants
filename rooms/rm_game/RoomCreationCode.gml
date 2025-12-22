/// rm_game - Room Creation Code

// ALWAYS call game_init first
game_init();

// Only start month 1 if we're just beginning
with (obj_applicant_controller) {
    if (global.current_month == 1 && !month_in_progress) {
        start_month(1);
    }
}

// Start background music (with safety check)
if (audio_exists(snd_we_still_share_the_same_sky)) {
    // Stop any existing music first
    if (audio_is_playing(snd_we_still_share_the_same_sky)) {
        audio_stop_sound(snd_we_still_share_the_same_sky);
    }
    audio_play_sound(snd_we_still_share_the_same_sky, 1, true);
    audio_sound_gain(snd_we_still_share_the_same_sky, 0.5, 0);
}