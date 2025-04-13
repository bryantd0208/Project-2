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

// --- COLLISIONS ---
if (place_meeting(x + hspeed, y, obj_CollisionTiles)) {
    hspeed = 0;
}
if (place_meeting(x, y + vspeed, obj_CollisionTiles)) {
    if (vspeed > 0) {
        vspeed = 0; // Stop falling when hitting ground
    }
}

// --- APPLY MOVEMENT ---
x += hspeed;
y += vspeed;

// --- FRICTION WHEN LANDED ---
if (grounded) {
    hspeed = lerp(hspeed, 0, 0.2); // Slow down horizontally
}

// --- HOP LOGIC ---
var player = instance_nearest(x, y, obj_Player);

if (player != noone) {
    var dist_to_player = point_distance(x, y, player.x, player.y);

    if (hop_cooldown > 0) {
        hop_cooldown -= 1; // Countdown
    }
    else if (grounded && dist_to_player < attack_range) {
        // Only pick a direction when about to jump

        var dx = player.x - x;
        var dy = player.y - y;

        // LIMIT the horizontal jump distance (fixed here!)
        var max_hop_distance = 64; // <- how far slime CAN jump per hop (this is fine to keep)
        
        var target_x = x + clamp(dx, -max_hop_distance, max_hop_distance);
        var target_y = y + clamp(dy, -max_hop_distance, max_hop_distance);
        
        var dir = point_direction(x, y, target_x, target_y);

        // --- Finalize velocity based on that direction ---
        hspeed = lengthdir_x(hop_speed, dir);
        vspeed = jump_strength;
        
        hop_cooldown = room_speed * 1.5; // 1.5 second cooldown after hop
    }
}
