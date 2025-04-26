// --- PLAYER TRACKING ---
var player = instance_nearest(x, y, obj_Player);

if (player != noone) {
    var dist_to_player = point_distance(x, y, player.x, player.y);

    // Face the player
    image_xscale = (player.x < x) ? -1 : 1;

    // --- ATTACK ---
    if (can_attack && dist_to_player < attack_range) {
        if (attack_cooldown <= 0) {
            if (variable_instance_exists(id, "skeleton_type")) {
                scr_perform_attack(skeleton_type);
            } else {
                scr_perform_attack(0); // default to MELEE if missing
            }
            attack_cooldown = attack_speed;
        }
    }
}

// --- ATTACK COOLDOWN TIMER ---
if (attack_cooldown > 0) {
    attack_cooldown -= 1;
}
