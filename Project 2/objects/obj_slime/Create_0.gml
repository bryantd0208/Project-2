// Slime physics setup
gravity = 0.3;
vspeed = 0;
hspeed = 0;

// Hop behavior
hop_cooldown = 0;
hop_speed = 2.5;
jump_strength = -5;
attack_range = 10;

// Health
enemy_hp = 50;
enum SlimeState {
    IDLE,
    WINDUP,
    JUMP,
    LAND
}

slime_state = SlimeState.IDLE;
animation_timer = 0;
