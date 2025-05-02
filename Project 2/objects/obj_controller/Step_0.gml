function scr_create_object_from_data(name, x, y, xscale, yscale, angle) {
    var obj_index = asset_get_index(name);
    if (!object_exists(obj_index)) {
        show_debug_message("⚠️ Object not found: " + name);
        return noone;
    }

    var inst = instance_create_layer(x, y, "Instances", obj_index);
    inst.image_xscale = xscale;
    inst.image_yscale = yscale;
    inst.image_angle = angle;

    // ✅ Safe fallback sprite assignment
    if (inst.sprite_index == -1 && object_exists(obj_CollisionTiles)) {
        inst.sprite_index = object_get_sprite(obj_CollisionTiles);
    }

    inst.visible = true;
    inst.image_alpha = 1;
    inst.image_blend = c_white;
    inst.depth = -10000;

    return inst;
}

// ─────────────────────────────────────────────────────────────────
if (!isLoaded) {
    // Clear existing instances
    with (obj_CollisionTiles) instance_destroy();
    with (obj_slime) instance_destroy();
    with (obj_bat) instance_destroy();
    with (obj_skeleton) instance_destroy();
    with (obj_Switch) instance_destroy();
    with (obj_pressureplate) instance_destroy();
    with (obj_Door) instance_destroy();

    // Ensure lever state map exists for this section
    if (!ds_map_exists(global.lever_states, current_background_index)) {
        var new_map = ds_map_create();
        ds_map_add_map(global.lever_states, current_background_index, new_map);
    }

    // Make sure layer is visible
    if (layer_exists("Instances")) {
        layer_set_visible("Instances", true);
    }

    // 🔥 Load platforms and objects from nested global.levels
    var section = global.levels[? global.current_level][? current_background_index + 1];
    var platform_data = section[? "platforms"];
    var object_data = section[? "objects"];

    // Create platforms
    for (var i = 0; i < array_length(platform_data); i++) {
        var p = platform_data[i];
        scr_create_object_from_data(p[0], p[1], p[2], p[3], p[4], p[5]);
    }

    // Create objects
    for (var j = 0; j < array_length(object_data); j++) {
        var o = object_data[j];
        var inst = scr_create_object_from_data(o[0], o[1], o[2], o[3], o[4], o[5]);

        if (is_undefined(inst)) continue;

        if (o[0] == "obj_Switch" && array_length(o) >= 8) {
            inst.lever_id = o[6];
            inst.is_locked = o[7];
            inst.section_index = current_background_index;
        } else if (o[0] == "obj_pressureplate" && array_length(o) >= 7) {
            inst.plate_id = o[6];
            inst.section_index = current_background_index;
        } else if (o[0] == "obj_scene" && array_length(o) >= 8) {
            inst.dialogue_lines = string_split(o[6], "|");
            inst.portrait_sprite = asset_get_index(o[7]);
        } else if (o[0] == "obj_marker" && array_length(o) >= 7) {
            inst.marker_id = o[6];
        }
    }

    // Asset layer visibility control
    var id1 = layer_get_id("Assets_1");
    var id2 = layer_get_id("Assets_2");
    var id3 = layer_get_id("Assets_3");

    layer_set_visible(id1, false);
    layer_set_visible(id2, false);
    layer_set_visible(id3, false);

    if (current_background_index == -1 && layer_exists("Assets_1") && id1 != -1) {
        layer_set_visible(id1, true);
    }
    if (current_background_index == 0 && layer_exists("Assets_2") && id2 != -1) {
        layer_set_visible(id2, true);
    }
    if (current_background_index == 1 && layer_exists("Assets_3") && id3 != -1) {
        layer_set_visible(id3, true);
    }

    isLoaded = true;
}



if (global.show_lever_message) {
    global.lever_message_timer -= 1;
    if (global.lever_message_timer <= 0) {
        global.show_lever_message = false;
    }
}

if (keyboard_check_pressed(ord("P"))) {
    global.show_pause_menu = !global.show_pause_menu;
}
if (global.show_pause_menu) {
    if (keyboard_check_pressed(ord("R"))) global.show_pause_menu = false;
    if (keyboard_check_pressed(ord("Q"))) room_goto(rm_MainMenu);
}

var section_width = 1920;

if (is_fading) {
    fade_alpha += fade_speed * fade_direction;

    if (fade_alpha >= 1 && fade_direction == 1) {
        fade_alpha = 1;
        fade_direction = -1;

        if (transition_direction == 1) {
            current_background_index += 1;
            obj_Player.x = 8;
            obj_Player.y -= 10;
        } else if (transition_direction == -1) {
            current_background_index -= 1;
            obj_Player.x = section_width - 40;
            obj_Player.y -= 10;
        }

        isLoaded = false;
    } else if (fade_alpha <= 0 && fade_direction == -1) {
        fade_alpha = 0;
        is_fading = false;
    }
}

if (current_background_index == -1) {
    if (obj_Player.x < 0) {
        obj_Player.x = 0;
        var random_line = wrong_way_lines[irandom(array_length(wrong_way_lines) - 1)];
        scr_start_dialogue([random_line], spr_zero_text);
    }

    if (obj_Player.x > section_width - 32) {
        obj_Player.x = section_width - 32;
    }

    if (obj_Player.x >= section_width - 32 && !is_fading) {
        is_fading = true;
        fade_direction = 1;
        fade_alpha = 0;
        fade_speed = 0.05;
        transition_direction = 1;
    }
} else {
    if (obj_Player.x < 0 && !is_fading) {
        is_fading = true;
        fade_direction = 1;
        fade_alpha = 0;
        fade_speed = 0.05;
        transition_direction = -1;
    } else if (obj_Player.x > section_width - 32 && !is_fading) {
        if (current_background_index < array_length(background_sprites) - 1) {
            is_fading = true;
            fade_direction = 1;
            fade_alpha = 0;
            fade_speed = 0.05;
            transition_direction = 1;
        } else {
            obj_Player.x = section_width - 32;
            var random_line = wrong_way_lines[irandom(array_length(wrong_way_lines) - 1)];
            scr_start_dialogue([random_line], spr_zero_text);
        }
    }
}

if (variable_global_exists("lever_flip_queue")) {
    var sec_index = current_background_index;

    if (ds_map_exists(global.lever_states, sec_index)) {
        var lever_map = global.lever_states[? sec_index];

        for (var i = 0; i < ds_list_size(global.lever_flip_queue); i++) {
            var entry = global.lever_flip_queue[| i];
            var lever_id = entry[0];
            var inst_id = entry[1];

            if (!ds_map_exists(lever_map, lever_id)) {
                lever_map[? lever_id] = true;
                global.levers_flipped += 1;
                show_debug_message("✅ Flipped Lever ID " + string(lever_id) + " in section " + string(sec_index));
            }
        }

        ds_list_clear(global.lever_flip_queue);
    }
}

if (keyboard_check_pressed(ord("R"))) {
    room_restart();
}

if (instance_exists(obj_Player)) {
    var target_x = obj_Player.x - (800 / 2);
    var target_y = obj_Player.y - (600 / 2);
    var new_x = lerp(camera_get_view_x(global.camera_main), target_x, 0.1);
    var new_y = lerp(camera_get_view_y(global.camera_main), target_y, 0.1);
    camera_set_view_pos(global.camera_main, new_x, new_y);
}

if (keyboard_check_pressed(ord("L"))) {
    scr_export_level(current_background_index);
}

if (keyboard_check_pressed(ord("H"))) {
    var layer_id = layer_get_id("Assets_2");
    var is_visible = layer_get_visible(layer_id);
    layer_set_visible(layer_id, !is_visible);
}

if (keyboard_check_pressed(ord("M"))) {
    global.show_minimap = !global.show_minimap;
}

if (global.timer_active) {
    if (global.level_timer > 0) {
        global.level_timer -= 1 / room_speed; // Decrease per second
    } else {
        global.level_timer = 0;
        global.timer_active = false;
    }
}
// --- LOSS CONDITION: Timer expired ---
if (global.level_timer <= 0 && !global.game_lost) {
    global.game_lost = true;
    room_goto(rm_Lose);
}

if (keyboard_check(vk_alt) && keyboard_check_pressed(ord("L"))) {
    global.levers_flipped = global.total_levers;
}
