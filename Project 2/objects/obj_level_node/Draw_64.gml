// --- First: Draw all connections between nodes ---
with (obj_level_node) {
    var list_size = array_length(connections);
    for (var i = 0; i < list_size; i++) {
        var target_level_id = connections[i];
        
        if (target_level_id == -1) {
            continue;
        }
        
        // Find the node with the matching level_id
        var other_node = noone;
        with (obj_level_node) {
            if (level_id == target_level_id) {
                other_node = id;
            }
        }
        
        if (other_node != noone) {
            // --- Set line color ---
            if (unlocked && other_node.unlocked) {
                draw_set_color(c_white);
            }
            else {
                draw_set_color(c_gray);
            }

            // --- Animate drawing only if THIS node has newly_unlocked_level ---
            if (newly_unlocked_level == target_level_id) {
                // This connection is still growing
                var px = lerp(x, other_node.x, line_reveal_progress);
                var py = lerp(y, other_node.y, line_reveal_progress);
                draw_line(x, y, px, py);
            }
            else {
                // Otherwise draw the full connection instantly
                draw_line(x, y, other_node.x, other_node.y);
            }
        }
    }
}

// --- Then: Draw all the circles (nodes) ---
with (obj_level_node) {
    if (unlocked) {
        draw_set_color(c_white);
    }
    else {
        draw_set_color(c_dkgray);
    }

    // Optional: Circle "pop-in" effect
    draw_circle(x, y, 8 * draw_progress, false);
}
