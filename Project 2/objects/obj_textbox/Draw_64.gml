if (visible || (abs(current_y - (room_height - 48 - 100)) > 1)) {
    // Draw semi-transparent background
    draw_set_color(c_black);
    draw_set_alpha(0.7);

    var margin = 48; // Adjust margin if needed
    var box_width = room_width - (margin * 2) - 256; // Updated to room_width
    var box_height = 100;
    var box_x = margin + 256;
    var box_y = current_y; // Use current_y now

    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);

    draw_set_alpha(1);

    // Draw text inside
    draw_set_color(c_white);
    draw_text(box_x + 16, box_y + 16, string_copy(current_text, 1, char_index));

    // Draw portrait if exists
    if (portrait_sprite != -1) {
        var portrait_x = margin - 256 + 64;
        var portrait_y = box_y + box_height - 256;
        
        var target_width = 512;
        var target_height = 512;
        
        var sprite_w = sprite_get_width(portrait_sprite);
        var sprite_h = sprite_get_height(portrait_sprite);

        var scale_x = target_width / sprite_w;
        var scale_y = target_height / sprite_h;
        
        draw_sprite_ext(portrait_sprite, 0, portrait_x, portrait_y, scale_x, scale_y, 0, c_white, 1);
    }
}
