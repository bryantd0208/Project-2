event_inherited()
// --- Skeleton Create Event Cleaned ---

enum SkeletonType { MELEE, RANGED }
enum SkeletonState { IDLE, WINDUP, SLIDE, LAND }

if (random(1) < 0.45) {
    skeleton_type = SkeletonType.RANGED;
} else {
    skeleton_type = SkeletonType.MELEE;
}
skeleton_state = SkeletonState.IDLE;
if (skeleton_type == SkeletonType.MELEE) {
    move_speed = random_range(1.2, 2.0);
    enemy_hp = irandom_range(100, 140);
    attack_range = 30;
    attack_speed = irandom_range(15, 25);
} else {
    move_speed = random_range(2.0, 3.0);
    enemy_hp = irandom_range(60, 90);
    attack_range = 350;
    attack_speed = irandom_range(80, 110);
}

// --- Movement and Gravity Settings ---
gravity_force = 0.3;       // Gravity acceleration per frame
fall_max_speed = 4;        // Maximum vertical fall speed
vspeed = 0;
hspeed = 0;
attack_cooldown = 0;
// --- Player Chase Variables ---
move_timer = 0;
move_distance = 15;

// --- Landing Behavior ---
has_landed_recently = false;
landed_timer = 0;
landed_cooldown = 15;     // Frames to "pause" movement after touching ground
was_grounded = false;
