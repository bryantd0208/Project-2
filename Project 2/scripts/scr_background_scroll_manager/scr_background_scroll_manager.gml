function scr_background_scroll_manager() {
    // --- Handle scrolling logic ---
    if (!transitioning) {
        if (obj_Player.x > (current_background + 1) * section_width - (section_width / 4)) {
            transitioning = true;
            transition_direction = 1;
        }
        else if (obj_Player.x < current_background * section_width + (section_width / 4)) {
            if (current_background > 0) {
                transitioning = true;
                transition_direction = -1;
            }
        }
    }

    if (transitioning) {
        scroll_x += scroll_speed * transition_direction;

        if (abs(scroll_x) >= section_width) {
            scroll_x = 0;
            current_background += transition_direction;
            transitioning = false;

            // Clamp to valid backgrounds
            current_background = clamp(current_background, 0, array_length(background_sprites) - 1);

            // 🛜 TELEPORT THE PLAYER 🛜
            obj_Player.x -= section_width * transition_direction;
        }
    }

    // ✨ Optional: clamp player to prevent walking off while NOT transitioning
    if (!transitioning) {
        var left_bound = current_background * section_width;
        var right_bound = (current_background + 1) * section_width;

        if (obj_Player.x < left_bound + 32) obj_Player.x = left_bound + 32;
        if (obj_Player.x > right_bound - 32) obj_Player.x = right_bound - 32;
    }
}
