event_inherited()
// --- Physics Setup ---
gravity = 0.3;
vspeed = 0;
hspeed = 0;

// --- Hop Behavior ---
hop_cooldown = 0;
hop_speed = 2.5;
jump_strength = -5;
attack_range = 160; // How close player must be to be targeted

// --- Health ---
enemy_hp = 50;

// --- State Setup ---
enum SlimeState {
    IDLE,
    WINDUP,
    JUMP,
    LAND
}
slime_state = SlimeState.IDLE;
animation_timer = 0;
