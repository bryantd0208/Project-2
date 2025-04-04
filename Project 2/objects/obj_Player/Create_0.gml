//depth = 0;

//if (room = rm_main_game) image_yscale = 1.5;

// Define movement states as an enum
enum PlayerState {
    WALKING,
    RUNNING,
    SNEAKING,
	IDLE
}

// Initialize player state
player_state = PlayerState.WALKING;

// Define movement speeds
base_speed = 2;
run_speed = 3.5;
sneak_speed = 1; // Half of base speed

// **Player Score**
global.player_score = 0;
