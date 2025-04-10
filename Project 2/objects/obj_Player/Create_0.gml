//depth = 0;

//if (room = rm_main_game) image_yscale = 1.5;

// Define movement states as an enum
enum PlayerState {
    WALKING,
    RUNNING,
    SNEAKING,
	IDLE
}

gravity_direction = 270

// Initialize player state
player_state = PlayerState.WALKING;

// Define movement speeds
base_speed = 3;
run_speed = 4.5;
sneak_speed = base_speed / 2; // Half of base speed
player_speed = base_speed

// **Player Score**
global.player_score = 0;
