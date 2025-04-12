function scr_move_to_adjacent_node(){
    /// @function scr_move_to_adjacent_node(dx, dy)
    /// @param dx The x offset direction
    /// @param dy The y offset direction

    var move_x = argument0;
    var move_y = argument1;

    if (current_node == noone) {
        return; // No current node selected
    }

    var best_node = noone;
    var best_score = 999999; // Big number (lower is better)

    // Search through current node's connections
    for (var i = 0; i < array_length(current_node.connections); i++) {
        var target_level_id = current_node.connections[i];

        if (target_level_id == -1) continue;

        // Find the node with matching level_id
        var node = noone;
        with (obj_level_node) {
            if (level_id == target_level_id) {
                node = id;
            }
        }

        if (node != noone && node.unlocked) {
            var dir_to_node = point_direction(current_node.x, current_node.y, node.x, node.y);

            // Directional movement logic
            if (move_x != 0) { // Moving left/right
                if (move_x < 0 && node.x < current_node.x) { // Left
                    var dist = abs(node.x - current_node.x);
                    if (dist < best_score) {
                        best_score = dist;
                        best_node = node;
                    }
                }
                if (move_x > 0 && node.x > current_node.x) { // Right
                    var dist = abs(node.x - current_node.x);
                    if (dist < best_score) {
                        best_score = dist;
                        best_node = node;
                    }
                }
            }
            if (move_y != 0) { // Moving up/down
                if (move_y < 0 && node.y < current_node.y) { // Up
                    var dist = abs(node.y - current_node.y);
                    if (dist < best_score) {
                        best_score = dist;
                        best_node = node;
                    }
                }
                if (move_y > 0 && node.y > current_node.y) { // Down
                    var dist = abs(node.y - current_node.y);
                    if (dist < best_score) {
                        best_score = dist;
                        best_node = node;
                    }
                }
            }
        }
    }

    if (best_node != noone) {
        target_node = best_node;
    }
}
