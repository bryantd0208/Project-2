// --- GROUND CHECK ---
var grounded = place_meeting(x, y + 1, obj_CollisionTiles);

// --- APPLY GRAVITY ---
if (!grounded) {
    vspeed += gravity;
}

// --- FALL SPEED CAP ---
var fall_max_speed = 6;
if (vspeed > fall_max_speed) {
    vspeed = fall_max_speed;
}

// --- HORIZONTAL COLLISION SAFE ---
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

// --- VERTICAL COLLISION SAFE ---
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

// --- FRICTION WHEN LANDED ---
if (grounded && abs(hspeed) > 0.1) {
    hspeed = lerp(hspeed, 0, 0.2);
}

// --- HOP LOGIC ---
var player = instance_nearest(x, y, obj_Player);

if (player != noone) {
    var dist_to_player = point_distance(x, y, player.x, player.y);

    if (hop_cooldown > 0) {
        hop_cooldown -= 1;
    }
    else if (grounded && dist_to_player < attack_range) {
        var dx = player.x - x;
        var dy = player.y - y;

        var max_hop_distance = 64;

        var target_x = x + clamp(dx, -max_hop_distance, max_hop_distance);
        var target_y = y + clamp(dy, -max_hop_distance, max_hop_distance);

        var dir = point_direction(x, y, target_x, target_y);

        hspeed = lengthdir_x(hop_speed, dir);
        vspeed = jump_strength;

        hop_cooldown = room_speed * 1.5;
    }
}
