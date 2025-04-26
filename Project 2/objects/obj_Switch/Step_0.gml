// Decrease cooldown if active
if (interaction_cooldown > 0) {
    interaction_cooldown -= 1;
}

// Check for interaction
if (place_meeting(x, y, obj_Player)) {
    if (keyboard_check_pressed(ord("E")) && interaction_cooldown <= 0) {
        if (!is_locked) {
            // Toggle state
            state = 1 - state;

            // Debug print
            show_debug_message("Lever ID: " + string(lever_id) + " | New State: " + string(state));

            // Reset cooldown
            interaction_cooldown = cooldown_time;
        }
    }
}