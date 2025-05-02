// Check if player or familiar is on it
var pressed_now = place_meeting(x, y, obj_Player) || place_meeting(x, y, obj_familiar);

// Handle activation
if (pressed_now && !pressed_by_player) {
    state = 1;
    pressed_by_player = true;
    show_debug_message("🔘 Plate ID: " + string(plate_id) + " | Activated!");

    // Notify controller to trigger logic with proper section
    if (instance_exists(obj_controller)) {
        with (obj_controller) {
            scr_trigger_plate_activation(other.plate_id, other.section_index);
        }
    }

} else if (!pressed_now && pressed_by_player) {
    state = 0;
    pressed_by_player = false;
    show_debug_message("🔘 Plate ID: " + string(plate_id) + " | Deactivated!");
}
