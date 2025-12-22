/// Create Event

// Position and size (x=0-310, y=0-240)
display_x = 10;
display_y = 10;
display_width = 290;
bar_height = 50;
bar_spacing = 5;

// Resource data
resources = [
    { name: "FOOD", color: c_green, icon: spr_resource_icon_food },
    { name: "WATER", color: c_blue, icon: spr_resource_icon_water },
    { name: "ENERGY", color: c_yellow, icon: spr_resource_icon_energy },
    { name: "SPIRIT", color: c_purple, icon: spr_resource_icon_spirit }
];

// Smooth resource drain
draining = false;
drain_targets = {
    food: 0,
    water: 0,
    energy: 0,
    spirit: 0
};
drain_speed = 0.5;  // Resources per frame

/// @desc Start smooth resource drain animation
function start_resource_drain(_food_loss, _water_loss, _energy_loss, _spirit_loss) {
    draining = true;
    
    // Set targets
    drain_targets.food = global.food - _food_loss;
    drain_targets.water = global.water - _water_loss;
    drain_targets.energy = global.energy - _energy_loss;
    drain_targets.spirit = global.spirit - _spirit_loss;
    
    // Clamp targets
    drain_targets.food = max(0, drain_targets.food);
    drain_targets.water = max(0, drain_targets.water);
    drain_targets.energy = max(0, drain_targets.energy);
    drain_targets.spirit = max(0, drain_targets.spirit);
}