draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

// Main message
draw_text(room_width / 2, room_height / 2 - 20, message);

// Time left (in seconds, rounded)
var time_left = ceil(timer / room_speed);
draw_text(room_width / 2, room_height / 2 + 20, "Returning to menu in: " + string(time_left) + "...");
