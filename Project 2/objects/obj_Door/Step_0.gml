// obj_Door Step Event

if (door_opened) {
    exit; // Already used
}

// Ensure lever tracking variables exist
if (!variable_global_exists("total_levers")) {
    global.total_levers = 0;
}
if (!variable_global_exists("levers_flipped")) {
    global.levers_flipped = 0;
}

// --- LEVER CHECK ---
var all_levers_flipped = (global.levers_flipped >= global.total_levers);

// --- INTERACTION ---
if (place_meeting(x, y, obj_Player)) {
    if (keyboard_check_pressed(ord("E"))) {
        if (all_levers_flipped) {
            door_opened = true;

            show_debug_message("Door entered! Advancing level.");

            global.current_level += 1;

            if (!array_contains(global.levels_unlocked, global.current_level)) {
                array_push(global.levels_unlocked, global.current_level);
            }

            show_debug_message("Levels unlocked: " + string(global.levels_unlocked));

            room_goto(rm_LevelSelect);
        } else {
            show_debug_message("Door is locked. Not all levers flipped!");
        }
    }
}
