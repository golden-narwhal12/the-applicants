/// Step Event

timer++;

if (timer >= duration) {
    instance_destroy();
}

// Rise upward
y -= rise_speed;

// Fade out
alpha = 1 - (timer / duration);