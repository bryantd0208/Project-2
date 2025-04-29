/// Player Create Event

enum PlayerState {
    WALKING,
    RUNNING,
    DEFENDING,
    ATTACKING,
    DAMAGED,
    IDLE
}

player_state = PlayerState.IDLE;

// --- Movement
hspeed = 0;
vspeed = 0;
base_speed = 1.5;
run_speed = 2;
sneak_speed = base_speed / 2;
player_speed = base_speed;

// --- Health
max_health = 100;
current_health = max_health;

// --- Gravity Control (manual!)
gravity_force = 0.3;       // Gravity acceleration per frame
gravity_flip = 1;           // 1 = normal, -1 = upside down
fall_max_speed = 4.5;       // Maximum falling speed
jump_force = 6.5;       // adjust to your liking (higher = bigger jumps)
// --- Damage Control
damage_timer = 0;
damage_taken = false;
knockback_target_hspeed = 0;
knockback_target_vspeed = 0;

// --- Global Variables
global.hit_freeze_timer = 0;
global.player_score = 0;

// --- Other
grounded = false;

wall_slide = false;
wall_dir = 0; // -1 for left wall, 1 for right wall
wall_slide_speed = 1; // How fast player slides down the wall
wall_jump_h_force = 3; // Horizontal push off
wall_jump_v_force = 5.5; // Upward force (same or a little less than normal jump)
