// --- Basic Game State ---
current_level = 1;
levels_unlocked = [1];
player_lives = 3;
points = 0;

// --- Background Transition Setup ---
background_sprites = [spr_Background1, spr_Background2, spr_Background3];
current_background = 0;
scroll_x = 0;
scroll_speed = 6;
transitioning = false;
transition_direction = 0;
section_width = 1920; // <<< Important so scripts can use it

background_sprites = [spr_Background2, spr_Background3]; 
// Only the NEXT backgrounds (spr_Background1 is already room's default)
current_background_index = -1; 
section_width = 1920; // Size of screen
wrong_way_lines = [
    "Something tells me I shouldn't go over there.",
    "I think that's the wrong direction.",
    "Maybe I shouldn't head that way."
];
// --- Global Pause Stuff ---
if (!variable_global_exists("game_won")) global.game_won = false;
if (!variable_global_exists("game_lost")) global.game_lost = false;
if (!variable_global_exists("show_pause_menu")) global.show_pause_menu = false;
