function scr_try_unlock_switch_from_rules() {
    var lever_id = argument0;
    var section_index = argument1;
    var true_index = section_index + 2;
    var sec_key = "level_" + string(global.current_level) + "_sec_" + string(true_index);


    if (!ds_map_exists(global.unlock_rules, sec_key)) exit;

    var rules = global.unlock_rules[? sec_key];
    var my_key = "switch_" + string(lever_id);
    if (!ds_map_exists(rules, my_key)) exit;

    var reqs = rules[? my_key];
    var unlocked = true;

    for (var i = 0; i < array_length(reqs); i++) {
        var cond = reqs[i];
        if (array_length(cond) < 1) { unlocked = false; continue; }

        var typ = cond[0];
        var ref_id = (array_length(cond) > 1) ? cond[1] : -1;
        var found = false;

        switch (typ) {
            case "plate":
                with (obj_pressureplate) {
                    if (plate_id == ref_id && section_index == argument1 && state == 1) {
                        found = true;
                    }
                }
                if (!found) {
                    unlocked = false;

                }
                break;

            case "switch":
                with (obj_Switch) {
                    if (lever_id == ref_id && section_index == argument1 && state == 1) {
                        found = true;
                    }
                }
                if (!found) {
                    unlocked = false;

                }
                break;

            case "monsters_cleared":
                found = !(instance_exists(obj_slime) || instance_exists(obj_bat) || instance_exists(obj_skeleton));
                if (!found) {
                    unlocked = false;

                }
                break;

            default:

                unlocked = false;
        }
    }


    if (unlocked) {
        var target_id = lever_id;
        var target_section = section_index;

        with (obj_Switch) {
            if (lever_id == target_id && section_index == target_section) {
                if (is_locked) {
                    is_locked = false;

                }
            }
        }
    }
}
