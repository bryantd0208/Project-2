if (visible) {
    char_timer += 1;
    
    if (char_timer >= char_speed) {
        char_timer = 0;
        
        // Slowly reveal characters (typewriter effect)
        if (char_index < string_length(current_text)) {
            char_index += 1;
        }
    }

    // Input to continue
    if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_enter)) {
        
        if (char_index < string_length(current_text)) {
            // Instantly show all text if still typing
            char_index = string_length(current_text);
        }
        else {
            // Move to next line
            text_index += 1;
            if (text_index < array_length(dialogue_lines)) {
                current_text = dialogue_lines[text_index];
                char_index = 0;
            }
            else {
                // End dialogue
                visible = false;
            }
        }
    }
}

// Set target_y to position 100px above the bottom of the screen
if (visible) {
    var margin = 48;
    var box_height = 100;
    target_y = room_height - margin - box_height - 100; // Final resting position (100px from bottom)
}
else {
    // Off-screen when invisible
    var box_height = 100;
    target_y = room_height + box_height + 50; // This is off-screen, the box will slide up
}

// Smoothly slide current_y towards target_y
current_y = lerp(current_y, target_y, slide_speed);
