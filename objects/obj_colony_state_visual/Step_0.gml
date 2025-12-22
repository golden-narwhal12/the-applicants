/// Step Event

// Calculate total resources
var total_resources = global.food + global.water + global.energy + global.spirit;

// Determine state based on total
if (total_resources > 140) {
    current_state = "thriving";
    current_sprite = state_sprites.thriving;
}
else if (total_resources > 100) {
    current_state = "stable";
    current_sprite = state_sprites.stable;
}
else if (total_resources > 60) {
    current_state = "declining";
    current_sprite = state_sprites.declining;
}
else {
    current_state = "critical";
    current_sprite = state_sprites.critical;
}