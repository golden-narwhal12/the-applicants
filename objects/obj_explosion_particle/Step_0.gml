/// Step Event

// Move
x += speed_x;
y += speed_y;
speed_y += gravity_y;

// Rotate
rotation += rotation_speed;

// Fade
alpha -= fade_speed;

if (alpha <= 0) {
    instance_destroy();
}