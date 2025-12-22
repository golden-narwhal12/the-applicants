/// Step Event

// Check hover
hover = point_in_rectangle(mouse_x, mouse_y, 
                           x - button_width/2, y - button_height/2,
                           x + button_width/2, y + button_height/2);

// Check click
if (hover && mouse_check_button_pressed(mb_left)) {
    // Reset game
    game_init();
    
    // Return to title screen
    room_goto(rm_title);
}