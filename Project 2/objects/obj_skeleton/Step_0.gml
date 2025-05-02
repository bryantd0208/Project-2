event_inherited();

// --- Gravity ---
if (!place_meeting(x, y + 1, obj_CollisionTiles)) {
    vspeed += gravity_force;
    if (vspeed > fall_max_speed) vspeed = fall_max_speed;
} else {
    vspeed = 0;
}

// --- Vertical Collision ---
if (place_meeting(x, y + vspeed, obj_CollisionTiles)) {
    var step_y = sign(vspeed);
    repeat(floor(abs(vspeed))) {
        if (!place_meeting(x, y + step_y, obj_CollisionTiles)) {
            y += step_y;
        } else {
            break;
        }
    }
    vspeed = 0;
} else {
    y += vspeed;
}

// --- FINAL Ground Check (AFTER moving) ---
var grounded = place_meeting(x, y + 1, obj_CollisionTiles);

// --- Player Detection ---
var player = instance_nearest(x, y, obj_Player);

if (player != noone) {
    var distance = point_distance(x, y, player.x, player.y);

    if (skeleton_type == SkeletonType.MELEE) {
        var move_dir = sign(player.x - x);
        var test_x = x + move_dir;

        if (grounded && !has_landed_recently) {
            var edge_safe = place_meeting(test_x, y + 1, obj_CollisionTiles);
            var foot_safe = place_meeting(x, y + 1, obj_CollisionTiles);

            if (!edge_safe || !foot_safe) {
                var fall_safe = false;
                var max_fall_distance = 100;

                for (var py = 1; py <= max_fall_distance; py++) {
                    if (place_meeting(test_x, y + py, obj_CollisionTiles)) {
                        fall_safe = true;
                        break;
                    }
                }

                if (fall_safe) {
                    hspeed = move_dir * move_speed;
                } else {
                    hspeed = 0;
                }
            } else {
                hspeed = move_dir * move_speed;
            }
        } else if (!grounded) {
            hspeed = move_dir * move_speed;
        }
    }
    else if (skeleton_type == SkeletonType.RANGED) {
        hspeed = 0;
    }
} else {
    hspeed = 0;
}

// --- Horizontal Movement ---
if (hspeed != 0) {
    var move_x = sign(hspeed);

    if (!place_meeting(x + move_x, y - 1, obj_CollisionTiles)) {
        x += move_x;
    } else {
        if (grounded) {
            vspeed = -5.5;
        } else {
            hspeed = 0;
        }
    }
}

// --- Extra Gravity ---
if (!place_meeting(x, y + 1, obj_CollisionTiles)) {
    vspeed += gravity_force;
    if (vspeed > fall_max_speed) vspeed = fall_max_speed;
} else {
    vspeed = 0;
}

// --- Extra Vertical Collision Pass ---
if (place_meeting(x, y + vspeed, obj_CollisionTiles)) {
    var step_y = sign(vspeed);
    repeat(floor(abs(vspeed))) {
        if (!place_meeting(x, y + step_y, obj_CollisionTiles)) {
            y += step_y;
        } else {
            break;
        }
    }
    vspeed = 0;
} else {
    y += vspeed;
}

// --- LANDING RECENTLY TIMER ---
if (grounded && !was_grounded) {
    has_landed_recently = true;
    landed_timer = landed_cooldown;
}
if (has_landed_recently) {
    landed_timer -= 1;
    if (landed_timer <= 0) {
        has_landed_recently = false;
    }
}
was_grounded = grounded;

// === SPRITE CONTROL ===
if (skeleton_type == SkeletonType.MELEE) {
    if (enemy_hp <= 0) {
        sprite_index = spr_skeleton_melee_death;
    }
    else if (attack_cooldown > 0 && player != noone && point_distance(x, y, player.x, player.y) < attack_range) {
        sprite_index = spr_skeleton_melee_attack;
    }
    else {
        sprite_index = spr_skeleton_melee_idle;
    }
}
else if (skeleton_type == SkeletonType.RANGED) {
    if (enemy_hp <= 0) {
        sprite_index = spr_skeleton_archer_death;
    }
    else if (attack_cooldown > 0 && player != noone && point_distance(x, y, player.x, player.y) < attack_range) {
        sprite_index = spr_skeleton_archer_attack;
    }
    else {
        sprite_index = spr_skeleton_archer_idle;
    }
}
