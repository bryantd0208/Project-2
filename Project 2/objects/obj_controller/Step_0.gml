if (!isLoaded) {
    // Destroy all existing tiles
    with (obj_CollisionTiles) {
        instance_destroy();
    }

    // Load new section
    var section_data = global.section_platforms[current_background_index + 1];
    var target_layer = "Instances";

    for (var i = 0; i < array_length(section_data); i++) {
        var obj_name = section_data[i][0];
        var obj_x = section_data[i][1];
        var obj_y = section_data[i][2];
        var obj_xscale = section_data[i][3];
        var obj_yscale = section_data[i][4];
        
        if (obj_name == "obj_CollisionTiles") {
            var inst = instance_create_layer(obj_x, obj_y, target_layer, obj_CollisionTiles);
            inst.image_xscale = obj_xscale;
            inst.image_yscale = obj_yscale;
            inst.visible = true;
        }
    }
	show_debug_message(current_background_index);
var id1 = layer_get_id("Assets_1");
var id2 = layer_get_id("Assets_2");
var id3 = layer_get_id("Assets_3");

// First: hide all
layer_set_visible(id1, false);
layer_set_visible(id2, false);
layer_set_visible(id3, false);

// Then toggle only the correct one
if (current_background_index == -1) {
    layer_set_visible(id1, true);
    show_debug_message("Showing Section 1");
}
else if (current_background_index == 0) {
    layer_set_visible(id2, true);
    show_debug_message("Showing Section 2");
}
else if (current_background_index == 1) {
    layer_set_visible(id3, true);
    show_debug_message("Showing Section 3");
}
else {
    show_debug_message("Unrecognized section");
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

if (current_background_index == -1) {
    // 🛡️ First room background (spr_Background1)

    if (obj_Player.x < 0) {
        obj_Player.x = 0; // ❌ Block left movement
        var random_line = wrong_way_lines[irandom(array_length(wrong_way_lines) - 1)];
        scr_start_dialogue([random_line], spr_zero_text);
    }

    if (obj_Player.x > section_width - 32) {
        obj_Player.x = section_width - 32; // ❌ Block right movement
    }

    // --- Move to section 0 if walk right ---
    if (obj_Player.x >= section_width - 32) {
        current_background_index += 1;
		isLoaded = false;
        obj_Player.x = 0; // Start left of next background
    }
}
else {
    // 🛡️ Inside custom backgrounds
    if (obj_Player.x < 0) {
        current_background_index -= 1;
		isLoaded = false;

        if (current_background_index == -1) {
            obj_Player.x = section_width - 32; // Return to main background
            var random_line = wrong_way_lines[irandom(array_length(wrong_way_lines) - 1)];
            scr_start_dialogue([random_line], spr_zero_text);
        } else {
            obj_Player.x = section_width - 32;
        }
    }
    else if (obj_Player.x > section_width - 32) {
        if (current_background_index < array_length(background_sprites) - 1) {
            current_background_index += 1;
			isLoaded = 0;
            obj_Player.x = 0;
        }
        else {
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
    var new_x = lerp(camera_get_view_x(global.camera), target_x, 0.1);
    var new_y = lerp(camera_get_view_y(global.camera), target_y, 0.1);
    camera_set_view_pos(global.camera, new_x, new_y);
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

		