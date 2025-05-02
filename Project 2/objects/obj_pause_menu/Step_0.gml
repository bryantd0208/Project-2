// Slide in/out menu animation
if (global.show_pause_menu) {
    menu_x = lerp(menu_x, menu_target_x, 0.2);
} else {
    menu_x = lerp(menu_x, display_get_gui_width() + 20, 0.2);
}

// Get mouse position in GUI coordinates
var gui_mouse_x = device_mouse_x_to_gui(0);
var gui_mouse_y = device_mouse_y_to_gui(0);

// Match button layout from Draw GUI
var padding = 30;
var spacing = 60;
var text_y = 30;
var resume_y = text_y + spacing * 1.5;
var quit_y = text_y + spacing * 2.5;
var button_height = 30;

// Hover detection
global.pause_hover_resume = point_in_rectangle(gui_mouse_x, gui_mouse_y, menu_x + padding, resume_y, menu_x + padding + 260, resume_y + button_height);
global.pause_hover_quit   = point_in_rectangle(gui_mouse_x, gui_mouse_y, menu_x + padding, quit_y,   menu_x + padding + 260, quit_y + button_height);

// Click detection
if (mouse_check_button_pressed(mb_left)) {
    if (global.pause_hover_resume) {
        global.show_pause_menu = false;
    }
    if (global.pause_hover_quit) {
        room_goto(rm_MainMenu);
    }
}
