// --- PLAYER TRACKING ---
var player = instance_nearest(x, y, obj_Player);

if (player != noone) {
    var dist_to_player = point_distance(x, y, player.x, player.y);

    // Face the player
    image_xscale = (player.x < x) ? -1 : 1;

    if (can_attack) {
        if (attack_cooldown <= 0) {
            if (dist_to_player < attack_range) {

                if (variable_instance_exists(id, "skeleton_type")) {
                    if (skeleton_type == SkeletonType.RANGED) {
                        // Check if player is within shooting cone
                        var dir_to_player = point_direction(x, y, player.x, player.y);

                        if (image_xscale == 1) {
                            // Facing right → check if player is between -45° and +45°
                            if (abs(angle_difference(0, dir_to_player)) <= 45) {
                                scr_perform_attack(skeleton_type);
                                attack_cooldown = attack_speed;
                            }
                        } else {
                            // Facing left → check if player is between 135° and 225°
                            if (abs(angle_difference(180, dir_to_player)) <= 45) {
                                scr_perform_attack(skeleton_type);
                                attack_cooldown = attack_speed;
                            }
                        }
                    }
                    else {
                        // Melee skeletons: just attack if close enough
                        scr_perform_attack(skeleton_type);
                        attack_cooldown = attack_speed;
                    }
                } else {
					if (object_get_name(object_index) == "obj_bat") {
    // Skip parent attack logic
    exit;
}
                    scr_perform_attack(0);
                    attack_cooldown = attack_speed;
                }
            }
        }
    }
}

// --- ATTACK COOLDOWN TIMER ---
if (attack_cooldown > 0) {
    attack_cooldown -= 1;
}
