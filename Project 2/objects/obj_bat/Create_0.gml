event_inherited(); // Inherit the basic enemy setup

// --- Enums ---
enum BatState {
    IDLE,
    CHARGE,
    RETREAT
}

// --- Bat Specific Stats ---
move_speed = random_range(1.5, 2.5);
attack_range = 150;
attack_speed = irandom_range(30, 45);
enemy_hp = irandom_range(30, 50);
hover_height = random_range(-10, 10);

// --- State + Movement ---
bat_state = BatState.IDLE;
hover_timer = 0;
cooldown_timer = 0;
hspeed = 0;
vspeed = 0;
