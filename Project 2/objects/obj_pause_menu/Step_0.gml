if (global.show_pause_menu) {
    menu_x = lerp(menu_x, menu_target_x, 0.2);
} else {
    menu_x = lerp(menu_x, room_width + 20, 0.2); // Slide out
}
