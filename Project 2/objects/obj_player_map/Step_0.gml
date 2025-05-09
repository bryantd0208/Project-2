// --- Step Event for obj_level_select_manager ---


// --- Refresh unlocked nodes every frame (only needed if levels_unlocked changes during game) ---
with (obj_level_node) {
    unlocked = array_contains(global.levels_unlocked, level_id);
}

// --- Move toward target node ---
if (target_node != noone) {
    var dx = target_node.x - x;
    var dy = target_node.y - y;
    var dist = point_distance(x, y, target_node.x, target_node.y);
    
    if (dist > move_speed) {
        var dir = point_direction(x, y, target_node.x, target_node.y);
        x += lengthdir_x(move_speed, dir);
        y += lengthdir_y(move_speed, dir);
    }
    else {
        // Arrived at node
        x = target_node.x;
        y = target_node.y;
        current_node = target_node;
        target_node = noone;
    }
}

// --- Input: move between unlocked neighboring nodes ---
if (current_node != noone && target_node == noone) {
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
        scr_move_to_adjacent_node(-1, 0);
    }
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
        scr_move_to_adjacent_node(1, 0);
    }
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        scr_move_to_adjacent_node(0, -1);
    }
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        scr_move_to_adjacent_node(0, 1);
    }
    
// Press Space or Enter to enter level
if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
    if (current_node.unlocked) {
        var level_room_name = "rm_Level_" + string(current_node.level_id);
        
        if (room_exists(asset_get_index(level_room_name))) {
            room_goto(asset_get_index(level_room_name));
            show_debug_message("Entering " + level_room_name);
        }
        else {
            show_debug_message("Error: Room " + level_room_name + " does not exist!");
        }
    }
}

}

// --- Cheat: Alt + L to unlock the next connected level ---
if (keyboard_check(vk_alt) && keyboard_check_pressed(ord("L"))) {
    if (current_node != noone) {
        for (var i = 0; i < array_length(current_node.connections); i++) {
            var target_level_id = current_node.connections[i];

            if (target_level_id != -1) {
                // Find the node with that level_id
                var next_node = noone;
                with (obj_level_node) {
                    if (level_id == target_level_id) {
                        next_node = id;
                    }
                }
                
                if (next_node != noone && !next_node.unlocked) {
                    // Unlock the node!
                    next_node.unlocked = true;
                    show_debug_message("Cheat: Unlocked Level ID " + string(next_node.level_id));
                    
                    // --- Also safely add it to global unlocked levels
                    if (instance_exists(obj_global_controller)) {
                        scr_unlock_level(next_node.level_id);
                    }

                    break; // Only unlock one node at a time
                }
            }
        }
    }
}

function array_contains(arr, val) {
    for (var i = 0; i < array_length(arr); i++) {
        if (arr[i] == val) {
            return true;
        }
    }
    return false;
}
