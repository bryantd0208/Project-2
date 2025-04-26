// obj_global_controller Create Event

global.current_level = 1; // 🔥 Now it's truly global
global.levels_unlocked = [1]; // 🔥 Now it's truly global
global.player_lives = 3;
global.points = 0; 
global.background_sprites = [];

if (!variable_global_exists("game_won")) global.game_won = false;
if (!variable_global_exists("game_lost")) global.game_lost = false;
if (!variable_global_exists("show_pause_menu")) {
    global.show_pause_menu = false;
}
