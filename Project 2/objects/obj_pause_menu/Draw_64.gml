if (global.show_pause_menu || menu_x < display_get_gui_width()) {
    var gui_width = display_get_gui_width();
    var gui_height = display_get_gui_height();

    var box_width = menu_width;
    var box_x = menu_x;
    var box_y = 0;
    var box_height = gui_height;

    // Background
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(20, 30, 40)); // Deep navy
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, true);

    draw_set_alpha(1);
    draw_set_color(make_color_rgb(100, 160, 190)); // Cool cyan border
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);

    // Font and text settings
    draw_set_font(fnt_pause);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var padding = 30;
    var text_x = box_x + padding;
    var text_y = box_y + padding;
    var spacing = 60;

    // Title
    draw_set_color(c_white);
    draw_text(text_x, text_y, "Pause Menu");

    // Resume Button
    var resume_y = text_y + spacing * 1.5;
    if (global.pause_hover_resume) {
        draw_set_color(make_color_rgb(120, 200, 255)); // Light blue on hover
    } else {
        draw_set_color(c_white);
    }
    draw_text(text_x, resume_y, "[R] Resume");

    // Quit Button
    var quit_y = text_y + spacing * 2.5;
    if (global.pause_hover_quit) {
        draw_set_color(make_color_rgb(255, 100, 100)); // Red-ish on hover
    } else {
        draw_set_color(c_white);
    }
    draw_text(text_x, quit_y, "[Q] Quit");
}
