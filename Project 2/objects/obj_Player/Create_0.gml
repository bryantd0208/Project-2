enum PlayerState {
    WALKING,
    RUNNING,
    DEFENDING,
    ATTACKING,
    DAMAGED,
    IDLE
}
global.hit_freeze_timer = 0; // Shared global freeze timer

damage_timer = 0;
damage_taken = false;
gravity = 0.4;         // Good value for platformers
gravity_direction = 270; // Downward

vspeed = 0; // Start falling naturally
knockback_target_hspeed = 0;
knockback_target_vspeed = 0;


// Initialize player state
player_state = PlayerState.IDLE;
max_health = 100;
current_health = max_health

// Define movement speeds
base_speed = 1.5;
run_speed = 2;
sneak_speed = base_speed / 2; // Half of base speed
player_speed = base_speed

// **Player Score**
global.player_score = 0;