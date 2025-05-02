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
current_background_index =1; 
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
display_set_gui_size(800, 600); // Match your GUI design resolution
display_set_gui_maximize();     // Makes it scale correctly on different screen sizes

global.camera_main = camera_create_view(0, 0, 800, 600, 0, obj_Player, -1, -1, 800, 600);
global.camera_minimap = camera_create_view(0, 0, 1920, 1080, 0, obj_Player, -1, -1, 1920, 1080);


view_enabled = true;
view_set_visible(0, true);
view_set_camera(0, global.camera_main);
isLoaded = false;

fade_alpha = 0;
fade_speed = 0.1;
is_fading = false;
fade_direction = 1; // 1 = fade out, -1 = fade in
callback = noone;

if (!variable_global_exists("total_levers")) {
    global.total_levers = 0;
}
if (!variable_global_exists("levers_flipped")) {
    global.levers_flipped = 0;
}

// --- Lever Message Display ---
global.show_lever_message = false; // Controls whether the "X levers remaining" text is shown
global.lever_message_timer = 0;    // Countdown timer for how long to show the message
if (!variable_global_exists("lever_flip_queue")) {
    global.lever_flip_queue = ds_list_create();
}
global.show_minimap = false;

global.level_timer = 300;
global.timer_active = true;
