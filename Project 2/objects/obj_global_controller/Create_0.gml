current_level = 1; // Current Level
levels_unlocked = [1]; // List of unlocked levels
player_lives = 3;
points = 0; 

// Only initialize if not already set (prevents overwriting if restarting)
if (!variable_global_exists("game_won")) global.game_won = false;
if (!variable_global_exists("game_lost")) global.game_lost = false;
if (!variable_global_exists("show_pause_menu")) {
    global.show_pause_menu = false;
}
