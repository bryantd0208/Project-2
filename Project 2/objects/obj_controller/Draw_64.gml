if (instance_exists(obj_Player)) {
    // --- Portrait crop settings ---
    var portrait_crop_x = 0;
    var portrait_crop_y = 0;
    var portrait_crop_width = 2048;
    var portrait_crop_height = 1024; // Top half of the sprite

    // Final display size
    var portrait_display_width = 128;
    var portrait_display_height = 64;

    // Where to center the portrait on screen
    var portrait_center_x = 20;
    var portrait_center_y = 10;

    // Scale factors
    var portrait_scale_x = portrait_display_width / portrait_crop_width;
    var portrait_scale_y = portrait_display_height / portrait_crop_height;

    // Offset to draw the sprite so it’s centered at the desired position
    var draw_x = portrait_center_x - (portrait_display_width / 2) + 24;
    var draw_y = portrait_center_y - (portrait_display_height / 2) + 24;

    // --- Draw Player Portrait (Top Half, Scaled Down & Centered) ---
    draw_sprite_part_ext(
        spr_zero_text,              // sprite
        0,                          // sub-image index
        portrait_crop_x,            // left
        portrait_crop_y,            // top
        portrait_crop_width,        // width
        portrait_crop_height,       // height
        draw_x,                     // x (adjusted for centering)
        draw_y,                     // y (adjusted for centering)
        portrait_scale_x,           // xscale
        portrait_scale_y,           // yscale
        c_white,                    // color
        1                           // alpha
    );

  // --- Health Bar Settings ---
    var bar_x = portrait_center_x + (portrait_display_width / 2) + 10;
    var bar_y = 20;
    var bar_width = 200;
    var bar_height = 20;

    var hp_percent = clamp(obj_Player.current_health / obj_Player.max_health, 0, 1);

    // --- Draw Health Bar ---
    draw_set_color(c_gray);
    draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

    // --- Set Health Bar Color Based on HP ---
    if (hp_percent > 0.75) {
        draw_set_color(c_lime); // Green
    }
    else if (hp_percent > 0.4) {
        draw_set_color(c_yellow); // Yellow
    }
    else {
        draw_set_color(c_red); // Red
    }

    // --- Draw HP Fill ---
    draw_rectangle(bar_x, bar_y, bar_x + (bar_width * hp_percent), bar_y + bar_height, false);

    // --- Draw Health Bar Border ---
    draw_set_color(c_black);
    draw_rectangle(bar_x - 1, bar_y - 1, bar_x + bar_width + 1, bar_y + bar_height + 1, true);

    // --- Draw Health Text ---
    draw_set_color(c_white);
    draw_text(bar_x + bar_width / 2 - 20, bar_y + bar_height / 2 - 6, string(floor(obj_Player.current_health)) + "/" + string(obj_Player.max_health));
}



if (instance_exists(obj_Player)) {
    // --- MINIMAP SETTINGS ---
    var minimap_x = 1300;
    var minimap_y = 10;
    var minimap_width = 200;
    var minimap_height = 150;

    var world_width = room_width;
    var world_height = room_height;

    // --- Background Box ---
    draw_set_color(c_black);
    draw_rectangle(minimap_x - 2, minimap_y - 2, minimap_x + minimap_width + 2, minimap_y + minimap_height + 2, true);

    draw_set_color(c_dkgray);
    draw_rectangle(minimap_x, minimap_y, minimap_x + minimap_width, minimap_y + minimap_height, false);

    // --- PLATFORM TILES ---
    with (obj_CollisionTiles) {
        if (bbox_left >= 0 && bbox_top >= 0 && bbox_right <= room_width && bbox_bottom <= room_height) {
            var tile_left = bbox_left / room_width * minimap_width;
            var tile_top  = bbox_top / room_height * minimap_height;
            var tile_right = bbox_right / room_width * minimap_width;
            var tile_bottom = bbox_bottom / room_height * minimap_height;

            draw_set_color(c_white);
            draw_rectangle(minimap_x + tile_left, minimap_y + tile_top, minimap_x + tile_right, minimap_y + tile_bottom, false);
        }
    }

    // --- PLAYER DOT ---
    if (obj_Player.x >= 0 && obj_Player.y >= 0 && obj_Player.x <= room_width && obj_Player.y <= room_height) {
        var player_x = obj_Player.x / world_width * minimap_width;
        var player_y = obj_Player.y / world_height * minimap_height;

        draw_set_color(c_lime);
        draw_circle(minimap_x + player_x, minimap_y + player_y, 3, false);
    }

    // --- ENEMY DOTS ---
    with (obj_enemy) {
        if (x >= 0 && y >= 0 && x <= room_width && y <= room_height) {
            var mm_x = x / room_width * minimap_width;
            var mm_y = y / room_height * minimap_height;
            draw_set_color(c_red);
            draw_circle(minimap_x + mm_x, minimap_y + mm_y, 2, false);
        }
    }

    // --- FAMILIAR DOT (Cyan) ---
    with (obj_familiar) {
        if (x >= 0 && y >= 0 && x <= room_width && y <= room_height) {
            var mm_fx = x / room_width * minimap_width;
            var mm_fy = y / room_height * minimap_height;
            draw_set_color(c_aqua); // Cyan color
            draw_circle(minimap_x + mm_fx, minimap_y + mm_fy, 2, false);
        }
    }
}

