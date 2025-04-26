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

// ✨ --- FINAL Ground Check (AFTER moving) ---
grounded = place_meeting(x, y + 1, obj_CollisionTiles);

// --- Player Detection ---
var player = instance_nearest(x, y, obj_Player);

if (player != noone) {
    var distance = point_distance(x, y, player.x, player.y);
    show_debug_message("Distance to player: " + string(distance));

    if (distance < 200) {
        var move_dir = sign(player.x - x);
        var test_x = x + move_dir;

        if (grounded && !has_landed_recently) {
            // --- Edge Check: Check ahead + also under feet a little ---
            var edge_safe = place_meeting(test_x, y + 1, obj_CollisionTiles);
            var foot_safe = place_meeting(x, y + 1, obj_CollisionTiles);

            if (!edge_safe || !foot_safe) {
                show_debug_message("Near edge! Checking fall safety...");

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
                    show_debug_message("Fall is SAFE. Moving toward player.");
                } else {
                    hspeed = 0;
                    show_debug_message("Fall is NOT safe. Stopping.");
                }
            } else {
                // Ground looks good
                hspeed = move_dir * move_speed;
                show_debug_message("Ground flat. Moving toward player.");
            }
        }
        else if (!grounded) {
            // Airborne → keep moving
            hspeed = move_dir * move_speed;
            show_debug_message("In air, continue moving toward player.");
        }
    }
    else {
        hspeed = 0;
        show_debug_message("Player too far. Standing still.");
    }
}

// --- Horizontal Movement ---
if (hspeed != 0) {
    var move_x = sign(hspeed);

    if (!place_meeting(x + move_x, y - 1, obj_CollisionTiles)) {
        // No wall ahead → Move normally
        x += move_x;
        show_debug_message("Moved horizontally to x = " + string(x));
    } else {
        if (grounded) {
            // Wall detected while grounded → Hop over!
            vspeed = -5.5; // Hop velocity (adjust if needed)
            show_debug_message("Wall detected while grounded! Hopping over!");
        } else {
            // Already in air → Block horizontal movement
            hspeed = 0;
            show_debug_message("Blocked horizontally while airborne. Cannot move.");
        }
    }
}

// --- Gravity (second call not really needed anymore, but safe) ---
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
