// Check if player (or later maybe even crates?) is standing on it
if (place_meeting(x, y, obj_Player) || place_meeting(x, y, obj_familiar)) {
    if (!pressed_by_player) {
        // Player just stepped on it
        state = 1;
        pressed_by_player = true;
        show_debug_message("Plate ID: " + string(plate_id) + " | Activated!");
    }
} else {
    if (pressed_by_player) {
        // Player stepped off
        state = 0;
        pressed_by_player = false;
        show_debug_message("Plate ID: " + string(plate_id) + " | Deactivated!");
    }
}