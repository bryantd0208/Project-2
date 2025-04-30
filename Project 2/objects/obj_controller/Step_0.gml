/// 📦 Helper: Dynamically creates an instance with safe defaults
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

    // Fallbacks for rendering
    if (inst.sprite_index == -1) inst.sprite_index = spr_CollisionTileTest;
    inst.visible = true;
    inst.image_alpha = 1;
    inst.image_blend = c_white;
    inst.depth = -10000;

    return inst;
}

// ─────────────────────────────────────────────────────────────────
if (!isLoaded) {
    // 🔄 Destroy all old instances
    with (obj_CollisionTiles) instance_destroy();
    with (obj_slime) instance_destroy();
    with (obj_bat) instance_destroy();
    with (obj_skeleton) instance_destroy();
    with (obj_Switch) instance_destroy();
    with (obj_pressureplate) instance_destroy();
    with (obj_Door) instance_destroy();

    // ✅ Ensure Instances layer is visible
    if (layer_exists("Instances")) {
        layer_set_visible("Instances", true);
    }

    // 📥 Load Platforms
    var platform_data = global.section_platforms[current_background_index + 1];
    for (var i = 0; i < array_length(platform_data); i++) {
        var p = platform_data[i];
        scr_create_object_from_data(p[0], p[1], p[2], p[3], p[4], p[5]);
    }

    // 👾 Load Objects
    var object_data = global.section_objects[current_background_index + 1];
    for (var j = 0; j < array_length(object_data); j++) {
        var o = object_data[j];
        var inst = scr_create_object_from_data(o[0], o[1], o[2], o[3], o[4], o[5]);

        // Add extra fields
        if (is_undefined(inst)) continue;

        if (o[0] == "obj_Switch" && array_length(o) >= 8) {
            inst.lever_id = o[6];
            inst.is_locked = o[7];
        }
        else if (o[0] == "obj_pressureplate" && array_length(o) >= 7) {
            inst.plate_id = o[6];
        }
    }

    // 🎨 Toggle decor layers
    var id1 = layer_get_id("Assets_1");
    var id2 = layer_get_id("Assets_2");
    var id3 = layer_get_id("Assets_3");
	
	show_debug_message(id2);
	
    layer_set_visible(id1, false);
    layer_set_visible(id2, false);
    layer_set_visible(id3, false);
	
	
		show_debug_message(layer_get_visible(id1))
	if (current_background_index == -1) {
    if (layer_exists("Assets_1") && id1 != -1) {
        layer_set_visible(id1, true);
        show_debug_message("Assets_1 is now visible.");
    } else {
        show_debug_message("Assets_1 does not exist or is invalid.");
    }
		show_debug_message(layer_get_visible(id1))
}
	
	
	
	
	
	show_debug_message(layer_get_visible(id2))
	if (current_background_index == 0) {
    if (layer_exists("Assets_2") && id2 != -1) {
        layer_set_visible(id2, true);
        show_debug_message("Assets_2 is now visible.");
    } else {
        show_debug_message("Assets_2 does not exist or is invalid.");
    }
		show_debug_message(layer_get_visible(id2))
}


	show_debug_message(layer_get_visible(id3))
	if (current_background_index == 1) {
    if (layer_exists("Assets_3") && id3 != -1) {
        layer_set_visible(id3, true);
        show_debug_message("Assets_3 is now visible.");
    } else {
        show_debug_message("Assets_3 does not exist or is invalid.");
    }
		show_debug_message(layer_get_visible(id3))
}



    isLoaded = true;
}




// --- Pause Menu ---
if (keyboard_check_pressed(ord("P"))) {
    global.show_pause_menu = !global.show_pause_menu;
}
if (global.show_pause_menu) {
    if (keyboard_check_pressed(ord("R"))) global.show_pause_menu = false;
    if (keyboard_check_pressed(ord("Q"))) room_goto(rm_MainMenu);
}

// --- Movement Blocking Based on Background ---
var section_width = 1920; // Width of each background screen

// --- Fade transition logic (put this near top of Step Event)
if (is_fading) {
    fade_alpha += fade_speed * fade_direction;

    if (fade_alpha >= 1 && fade_direction == 1) {
        fade_alpha = 1;
        fade_direction = -1;

        // Perform section switch after fade-in
        if (transition_direction == 1) { // Move right
            current_background_index += 1;
            obj_Player.x = 8; // Start slightly into new section
            obj_Player.y -= 10; // Nudge upward to avoid floor overlap
        } 
        else if (transition_direction == -1) { // Move left
            current_background_index -= 1;
            obj_Player.x = section_width - 40; // Slightly inside left edge
            obj_Player.y -= 10;
        }

        isLoaded = false;
    }
    else if (fade_alpha <= 0 && fade_direction == -1) {
        fade_alpha = 0;
        is_fading = false;
    }
}

// --- Section transition triggers (replaces direct background index changes)
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
        // 🔁 Start fade to move right
        is_fading = true;
        fade_direction = 1;
        fade_alpha = 0;
        fade_speed = 0.05;
        transition_direction = 1;
    }
}
else {
    if (obj_Player.x < 0 && !is_fading) {
        // 🔁 Fade to return left (main section or previous)
        is_fading = true;
        fade_direction = 1;
        fade_alpha = 0;
        fade_speed = 0.05;
        transition_direction = -1;
    }
    else if (obj_Player.x > section_width - 32 && !is_fading) {
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

// --- Restart Room (for testing) ---
if (keyboard_check_pressed(ord("R"))) {
    room_restart();
}

// --- Smooth Camera Following ---
if (instance_exists(obj_Player)) {
    var target_x = obj_Player.x - (800 / 2);
    var target_y = obj_Player.y - (600 / 2);
    var new_x = lerp(camera_get_view_x(global.camera_main), target_x, 0.1);
    var new_y = lerp(camera_get_view_y(global.camera_main), target_y, 0.1);
    camera_set_view_pos(global.camera_main, new_x, new_y);
}

// --- Export Level (for debugging)
if (keyboard_check_pressed(ord("L"))) {
    scr_export_level(current_background_index);
}


if (keyboard_check_pressed(ord("H"))) {
    // Toggle Asset_1 layer visibility
    var layer_id = layer_get_id("Assets_2");
    var is_visible = layer_get_visible(layer_id);
    layer_set_visible(layer_id, !is_visible);

}

		