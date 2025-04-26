// obj_Door Step Event

if (door_opened) {
    exit; // Already used
}

// Check if player is colliding with door
if (place_meeting(x, y, obj_Player)) {
    if (keyboard_check_pressed(ord("E"))) {
        // Player pressed E while touching door
        door_opened = true;

        // --- WIN CONDITION ---
        show_debug_message("Door entered! Advancing level.");

        // Increase current_level
        global.current_level += 1;

        // Only add the level if it's not already unlocked
        if (!array_contains(global.levels_unlocked, global.current_level)) {
            array_push(global.levels_unlocked, global.current_level);
        }

        // Debugging: show what levels are unlocked now
        show_debug_message("Levels unlocked: " + string(global.levels_unlocked));

        // Go back to Level Select Room
        room_goto(rm_LevelSelect);
    }
}
