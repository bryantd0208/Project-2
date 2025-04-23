// Toggle pause menu with P
if (keyboard_check_pressed(ord("P"))) {
    global.show_pause_menu = !global.show_pause_menu;
}


if (global.show_pause_menu) {
    // Resume
    if (keyboard_check_pressed(ord("R"))) {
        global.show_pause_menu = false;
    }

    // Quit to menu
    if (keyboard_check_pressed(ord("Q"))) {
        room_goto(rm_MainMenu); // Replace with your actual menu room name
    }
}
