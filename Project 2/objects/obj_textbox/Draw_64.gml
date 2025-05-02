if (visible) {
    var margin = 48;
    var gui_width = display_get_gui_width();
    var gui_height = display_get_gui_height();

    var portrait_width = 256;
    var box_width = gui_width - (margin * 2) - portrait_width;
    var box_height = 100;

    var box_x = margin + portrait_width;
    var box_y = current_y;

    // === TEXTBOX BACKGROUND ===
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);
    draw_set_alpha(1);

    // === TEXT ===
    draw_set_color(c_white);
    draw_set_font(fnt_ui);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var text_x = box_x + 16;
    var text_y = box_y + 12;

    draw_text(text_x, text_y, string_copy(current_text, 1, char_index));

    // === PORTRAIT (if exists) ===
    if (portrait_sprite != -1) {
        var portrait_x = margin; // clean left alignment
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
