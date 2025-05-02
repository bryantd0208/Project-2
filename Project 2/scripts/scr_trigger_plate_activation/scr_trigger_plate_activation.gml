function scr_trigger_plate_activation() {
    var plate_id = argument0;
    var section_index = argument1;
    var my_section = section_index;

    var true_index = section_index + 2;
    var sec_key = "level_" + string(global.current_level) + "_sec_" + string(true_index);

    if (!ds_map_exists(global.unlock_rules, sec_key)) exit;

    var rules = global.unlock_rules[? sec_key];
    var my_key = "plate_" + string(plate_id);

    if (!ds_map_exists(rules, my_key)) exit;

    var unlock_targets = rules[? my_key];

    // ✅ Validate required plate dependencies FIRST
    for (var i = 0; i < array_length(unlock_targets); i++) {
        var target = unlock_targets[i];
        if (target[0] == "plate") {
            var ref_id = target[1];
            var found = false;
            var sec = section_index;

            with (obj_pressureplate) {
                if (plate_id == ref_id && section_index == sec && state == 1) {
                    found = true;
                }
            }

            if (!found) {
                show_debug_message("⚠️ Dependency Plate " + string(ref_id) + " not pressed in section " + string(sec));
                exit;
            }
        }
    }

    // ✅ Apply unlocks
    for (var i = 0; i < array_length(unlock_targets); i++) {
        var target = unlock_targets[i];
        var typ = target[0];
        var ref_id = (array_length(target) > 1) ? target[1] : -1;
        var sec = section_index;

        switch (typ) {
            case "switch":
                with (obj_Switch) {
                    if (lever_id == ref_id && section_index == sec && is_locked) {
                        is_locked = false;
                        show_debug_message("🔓 Switch " + string(lever_id) + " unlocked via Plate " + string(plate_id));
                        // 🔁 Trigger switch result logic (e.g., gravity flip)
                        scr_try_unlock_switch_from_rules(lever_id, section_index);
                    }
                }
                break;

            case "door":
                with (obj_Door) {
                    if (!is_unlocked) {
                        is_unlocked = true;
                        show_debug_message("🚪 Door unlocked via Plate " + string(plate_id));
                    }
                }
                break;

            case "plate": break; // Already validated

            case "gravity_flip":
                show_debug_message("⚠️ Ignored gravity flip in plate activation. Use plate_X_result instead.");
                break;

            default:
                show_debug_message("⚠️ Unknown unlock target: " + string(typ));
        }
    }

    // ✅ Apply plate_X_result actions (e.g., gravity_flip)
    var result_key = "plate_" + string(plate_id) + "_result";
    if (ds_map_exists(rules, result_key)) {
        var results = rules[? result_key];
        for (var j = 0; j < array_length(results); j++) {
            var action = results[j][0];

            switch (action) {
                case "gravity_flip":
                    scr_gravity_flip();
                    show_debug_message("🌀 Gravity flipped via plate " + string(plate_id));
                    break;

                default:
                    show_debug_message("⚠️ Unknown plate result action: " + string(action));
            }
        }
    }

    show_debug_message("🚨 Plate " + string(plate_id) + " tried to unlock targets in section " + string(my_section));
}
