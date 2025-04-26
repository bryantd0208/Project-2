event_inherited()
// --- Skeleton Create Event Cleaned ---

enum SkeletonType { MELEE, RANGED }
enum SkeletonState { IDLE, WINDUP, SLIDE, LAND }

skeleton_type = SkeletonType.MELEE;
skeleton_state = SkeletonState.IDLE;

// --- Movement and Gravity Settings ---
move_speed = 1.5;         // Horizontal move speed
gravity_force = 0.3;       // Gravity acceleration per frame
fall_max_speed = 4;        // Maximum vertical fall speed
vspeed = 0;
hspeed = 0;

// --- Player Chase Variables ---
move_timer = 0;
move_distance = 15;

// --- Landing Behavior ---
has_landed_recently = false;
landed_timer = 0;
landed_cooldown = 15;     // Frames to "pause" movement after touching ground
was_grounded = false;
