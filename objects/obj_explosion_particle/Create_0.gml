/// Create Event

// Particle properties
start_x = x;
start_y = y;
speed_x = random_range(-8, 8);
speed_y = random_range(-8, 8);
gravity_y = 0.3;
rotation = random(360);
rotation_speed = random_range(-10, 10);
alpha = 1;
fade_speed = 0.02;
scale = random_range(0.3, 0.8);

// Sprite fragment (will be set by creator)
fragment_sprite = -1;
fragment_subimage = 0;

depth = -100;