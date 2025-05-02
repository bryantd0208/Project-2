// === COOLDOWN TIMER ===
if (interaction_cooldown > 0) {
    interaction_cooldown -= 1;
}

// === INTERACTION ===
if (place_meeting(x, y, obj_Player)) {
    if (keyboard_check_pressed(ord("E")) && interaction_cooldown <= 0) {
        show_debug_message(string(lever_id) + ":" + string(state));
        
        if (!is_locked && !flip_registered) {
            // Toggle state
            state = 1 - state;

            // Prevent duplicate flips
            flip_registered = true;

            // Ensure lever flip queue exists
            if (!variable_global_exists("lever_flip_queue")) {
                global.lever_flip_queue = ds_list_create();
            }

            // Add to queue (used for tracking across section loads)
            var entry = [lever_id, id];
            ds_list_add(global.lever_flip_queue, entry);

            // Feedback
            global.show_lever_message = true;
            global.lever_message_timer = 90;
            show_debug_message("✅ Lever ID " + string(lever_id) + " flipped. State: " + string(state));

            // === Trigger switch_X_result effects (e.g., gravity flip) ===
            var result_key = "switch_" + string(lever_id) + "_result";
            var sec_key = "level_" + string(global.current_level) + "_sec_" + string(section_index + 2);

            if (ds_map_exists(global.unlock_rules, sec_key)) {
                var rule_map = global.unlock_rules[? sec_key];

                if (ds_map_exists(rule_map, result_key)) {
                    var result_actions = rule_map[? result_key];

                    for (var i = 0; i < array_length(result_actions); i++) {
                        var action = result_actions[i][0];

                        switch (action) {
                            case "gravity_flip":
                                scr_gravity_flip();
                                show_debug_message("🌀 Gravity flipped via Switch " + string(lever_id));
                                break;

                            default:
                                show_debug_message("⚠️ Unknown switch result action: " + string(action));
                        }
                    }
                }
            }

            // Reset cooldown
            interaction_cooldown = cooldown_time;
        }
    }
}

// === UNLOCK ATTEMPT ===
// Run this once per frame if still locked, to check if it *can* now unlock
if (is_locked && instance_exists(obj_controller)) {
    var my_id = lever_id;
    var my_sec = section_index;

    with (obj_controller) {
        scr_try_unlock_switch_from_rules(my_id, my_sec);
    }
}
