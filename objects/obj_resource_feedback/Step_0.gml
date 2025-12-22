/// Step Event

timer++;

if (timer >= duration) {
    instance_destroy();
}

// Rise upward
y -= rise_speed;

// Fade in, then out
if (timer < 10) {
    alpha = timer / 10;
} else {
    alpha = 1 - ((timer - 10) / (duration - 10));
}