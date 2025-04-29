// --- Basic Game State ---
current_level = 1;
levels_unlocked = [1];
player_lives = 3;
points = 0;

// --- Background Transition Setup ---
background_sprites = [spr_MainMenuBackground, spr_Background2, spr_Background3];
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

// --- Gravity Flip Control ---
global.gravity_flipping = false;
global.gravity_flip_timer = 0;
global.gravity_flip_duration = 0;
global.gravity_target_scale = 1;
global.gravity_target_gravity = gravity;


global.camera = camera_create_view(0, 0, 800, 600, 0, obj_Player, -1, -1, 800, 600);


view_enabled = false;
view_set_visible(0, true);
view_set_camera(0, global.camera);
isLoaded = false;

