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
                }
            }

            slime_state = SlimeState.JUMP;
            image_index = 6; // Start at Frame 7
            image_speed = 0.5;
            hop_cooldown = room_speed * 1.5; // ~1.5 second cooldown
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
