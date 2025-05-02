// --- Ground Check ---
var grounded = place_meeting(x, y + 1, obj_CollisionTiles);

// --- Gravity ---
if (!grounded) {
    vspeed += gravity;
}
if (vspeed > 6) vspeed = 6;

// --- Cooldown Timer ---
if (hop_cooldown > 0) {
    hop_cooldown -= 1;
}

// --- SLIME STATE MACHINE ---
switch (slime_state) {

    // ---------------- IDLE ----------------
    case SlimeState.IDLE:
        image_index = 0; // Frame 1
        image_speed = 0;

        if (hop_cooldown <= 0 && grounded) {
            slime_state = SlimeState.WINDUP;
            animation_timer = 5; // Frames 2–6
            image_index = 1;
            image_speed = 5 / animation_timer;
        }
        break;

    // ---------------- WINDUP ----------------
    case SlimeState.WINDUP:
        animation_timer -= 1;
        if (animation_timer <= 0) {
            var player = instance_nearest(x, y, obj_Player);
            var jumped = false;

            if (player != noone) {
                var dist = point_distance(x, y, player.x, player.y);

                if (dist <= attack_range) {
                    var dx = player.x - x;
                    var dy = player.y - y;

                    var target_x = x + clamp(dx, -64, 64);
                    var target_y = y + clamp(dy, -64, 64);
                    var dir = point_direction(x, y, target_x, target_y);

                    hspeed = lengthdir_x(hop_speed, dir);
                    vspeed = jump_strength;
                    jumped = true;
                }
            }

            // Try to follow a marker path if not attacking player
            if (!jumped) {
                marker_target = noone;
                var best_distance = 300;

                with (obj_marker) {
                    if (marker_id == other.current_marker_id) {
                        var dist = point_distance(other.x, other.y, x, y);
                        if (dist < best_distance) {
                            best_distance = dist;
                            other.marker_target = id;
                        }
                    }
                }

                if (marker_target != noone) {
                    var dir = point_direction(x, y, marker_target.x, marker_target.y);
                    hspeed = lengthdir_x(hop_speed, dir);
                    vspeed = jump_strength;

                    if (marker_forward) {
                        current_marker_id += 1;
                    } else {
                        current_marker_id -= 1;
                    }

                    var found = false;
                    with (obj_marker) {
                        if (marker_id == other.current_marker_id) {
                            found = true;
                        }
                    }

                    if (!found) {
                        marker_forward = !marker_forward;
                        current_marker_id += marker_forward ? 1 : -1;
                    }
                }
            }

// 🔊 Play hop sound only if the player is close enough
if (player != noone) {
    var dist = point_distance(x, y, player.x, player.y);
    if (dist <= 650) {
        var vol = clamp(1 - (dist / 650), 0, 1);
        audio_play_sound_at(snd_slime, x, y, 0, 1, 1, vol, false, 0);
    }
}



            slime_state = SlimeState.JUMP;
            image_index = 6;
            image_speed = 0.5;
            hop_cooldown = room_speed * 1.5;
        }
        break;

    // ---------------- JUMP ----------------
    case SlimeState.JUMP:
        if (grounded) {
            slime_state = SlimeState.LAND;
            image_index = 17; // Frame 18
            image_speed = 0.2;
            animation_timer = 5;
        }
        break;

    // ---------------- LAND ----------------
    case SlimeState.LAND:
        animation_timer -= 1;
        if (animation_timer <= 0) {
            slime_state = SlimeState.IDLE;
        }
        break;
}

// --- Horizontal Collision ---
if (place_meeting(x + hspeed, y, obj_CollisionTiles)) {
    var move_x = sign(hspeed);
    repeat(abs(hspeed)) {
        if (!place_meeting(x + move_x, y, obj_CollisionTiles)) {
            x += move_x;
        } else {
            break;
        }
    }
    hspeed = 0;
} else {
    x += hspeed;
}

// --- Vertical Collision ---
if (place_meeting(x, y + vspeed, obj_CollisionTiles)) {
    var move_y = sign(vspeed);
    repeat(abs(vspeed)) {
        if (!place_meeting(x, y + move_y, obj_CollisionTiles)) {
            y += move_y;
        } else {
            break;
        }
    }
    vspeed = 0;
} else {
    y += vspeed;
}

// --- Friction ---
if (grounded && abs(hspeed) > 0.1) {
    hspeed = lerp(hspeed, 0, 0.2);
}
