function scr_unlock_level(level_id) {
    /// @function scr_unlock_level(level_id)
    /// @param level_id The ID of the level to unlock

    function array_contains(arr, val) {
        for (var i = 0; i < array_length(arr); i++) {
            if (arr[i] == val) {
                return true;
            }
        }
        return false;
    }

    var level_to_unlock = argument0;

    // Make sure the global controller exists
    if (instance_exists(obj_global_controller)) {

        // Check if the level is already unlocked
        if (!array_contains(global.levels_unlocked, level_to_unlock)) {
            array_push(global.levels_unlocked, level_to_unlock);
            show_debug_message("Unlocked level: " + string(level_to_unlock));

            // --- Now animate the connection! ---
            with (obj_level_node) {
                // For ALL nodes, check if THIS node has a connection TO the newly unlocked level
                for (var i = 0; i < array_length(connections); i++) {
                    if (connections[i] == level_to_unlock) {
                        newly_unlocked_level = level_to_unlock;
                        line_reveal_progress = 0; // Animate that line
                    }
                }
            }
        }
    }
    else {
        show_debug_message("Error: No global controller found!");
    }
}
