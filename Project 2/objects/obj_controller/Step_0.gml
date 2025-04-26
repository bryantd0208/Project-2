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
        obj_Player.x = section_width - 32; // ❌ Block right movement to next area
    }

    // Check if player reaches right side to switch backgrounds
    if (obj_Player.x >= section_width - 32) {
        current_background_index += 1;
        obj_Player.x = 0; // Start left side of next background
    }
}
else {
    // 🛡️ Inside custom backgrounds
    if (obj_Player.x < 0) {
        // Move back to previous background
        current_background_index -= 1;

        if (current_background_index == -1) {
            obj_Player.x = section_width - 32; // Back to room background (right edge)

            // ❗ Wrong way dialogue when trying to leave room left
            var random_line = wrong_way_lines[irandom(array_length(wrong_way_lines) - 1)];
            scr_start_dialogue([random_line], spr_zero_text);
        } else {
            obj_Player.x = section_width - 32; // Previous sprite's right side
        }
    }
    else if (obj_Player.x > section_width - 32) {
        if (current_background_index < array_length(background_sprites) - 1) {
            // Go to next background
            current_background_index += 1;
            obj_Player.x = 0; // Start left side
        }
        else {
            // ❌ On last background: block at right edge
            obj_Player.x = section_width - 32;

            // ❗ Wrong way dialogue when trying to leave rightmost background
            var random_line = wrong_way_lines[irandom(array_length(wrong_way_lines) - 1)];
            scr_start_dialogue([random_line], spr_zero_text);
        }
    }
}
