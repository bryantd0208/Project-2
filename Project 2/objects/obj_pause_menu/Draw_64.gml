if (global.show_pause_menu || menu_x < room_width) {
    // --- BACKGROUND SLIDE-IN PANEL ---
    var box_width = menu_width;
    var box_x = menu_x;
    var box_y = 0;
    var box_height = room_height;

    // Background: semi-transparent light gray
    draw_set_alpha(0.85);
    draw_set_color(make_color_rgb(230, 230, 230)); // light gray
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, true);
    draw_set_alpha(0.2);

    // Optional: outline
    draw_set_color(c_white);
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);
	
	draw_set_alpha(1);
    // --- TEXT OPTIONS ---
    draw_set_font(fnt_pause);
    draw_set_color(c_black); // darker text since background is light now
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var padding = 30;
    var text_x = box_x + padding;
    var text_y = box_y + padding;
    var spacing = 60;

    draw_text(text_x, text_y, "Pause Menu");
    draw_text(text_x, text_y + spacing * 1.5, "[R] Resume");
    draw_text(text_x, text_y + spacing * 2.5, "[Q] Quit");
}
