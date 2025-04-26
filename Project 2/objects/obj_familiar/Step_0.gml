if (instance_exists(obj_Player)) {
    // --- Update gravity from player ---
    gravity_flip = obj_Player.gravity_flip;
    gravity_force = obj_Player.gravity_force;
    fall_max_speed = obj_Player.fall_max_speed;

    // --- Update Follow Distance Occasionally ---
    follow_timer += 1;
    if (follow_timer > 30) {
        follow_distance = 40 + irandom_range(0, 40);
        follow_timer = 0;
    }

    var target_x = obj_Player.x - (obj_Player.image_xscale * follow_distance);
    var target_y = obj_Player.y;

    var dx = target_x - x;
    var dy = target_y - y;
    var dist = point_distance(x, y, target_x, target_y);

    // --- TELEPORT if too far ---
    if (dist > 400) {
        x = obj_Player.x;
        y = obj_Player.y;
        hspeed = 0;
        vspeed = 0;
        grounded = false;
        exit;
    }

    // --- MOVE toward player ---
    var move_speed = 1.5;
    if (abs(dx) > 4) {
        hspeed = move_speed * sign(dx);
    } else {
        hspeed = 0;
    }

    // --- WALL DETECTION ---
    wall_dir = 0;
    if (place_meeting(x + sign(hspeed), y, obj_CollisionTiles)) {
        wall_dir = sign(hspeed);
    }

    // --- GRAVITY AND WALL CLIMBING ---
    var applying_gravity = true;
    
    if (!place_meeting(x, y + gravity_flip, obj_CollisionTiles)) {
        grounded = false;
    } else {
        grounded = true;
    }

    if (!grounded) {
        if (wall_dir != 0 && !place_meeting(x, y + gravity_flip, obj_CollisionTiles)) {
            // Only climb if NOT grounded and touching side wall
            vspeed = -1.0 * gravity_flip;
            applying_gravity = false;
        }
    }

    if (applying_gravity) {
        vspeed += gravity_force * gravity_flip;
        if (abs(vspeed) > fall_max_speed) {
            vspeed = fall_max_speed * gravity_flip;
        }
    }

    // --- HOP if vertical gap big ---
    var vertical_gap = (target_y - y) * gravity_flip;
    if (grounded && vertical_gap < -16) {
        vspeed = -4 * gravity_flip;
    }

    // --- COLLISIONS ---

    // Horizontal Collision
    if (place_meeting(x + hspeed, y, obj_CollisionTiles)) {
        if (hspeed != 0) {
            while (!place_meeting(x + sign(hspeed), y, obj_CollisionTiles)) {
                x += sign(hspeed);
            }
        }
        hspeed = 0;
    }
    x += hspeed;

    // Vertical Collision
    if (place_meeting(x, y + vspeed, obj_CollisionTiles)) {
        if (vspeed != 0) {
            while (!place_meeting(x, y + sign(vspeed), obj_CollisionTiles)) {
                y += sign(vspeed);
            }
        }
        vspeed = 0;
    }
    y += vspeed;
}
