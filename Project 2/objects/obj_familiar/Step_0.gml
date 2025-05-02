if (instance_exists(obj_Player)) {
    // Sync gravity
    gravity_flip = obj_Player.gravity_flip;
    gravity_force = obj_Player.gravity_force;
    fall_max_speed = obj_Player.fall_max_speed;

    var apply_gravity = true;
    var apply_horizontal = true;

    // --- Handle teleport targeting ---
    if (global.familiar_mode == 1) {
        hspeed = 0;

        if (mouse_check_button_pressed(mb_left)) {
            global.familiar_target_x = mouse_x;
            global.familiar_target_y = mouse_y;

            show_debug_message("Familiar target selected at: " + string(global.familiar_target_x) + ", " + string(global.familiar_target_y));

            var fx = instance_create_layer(global.familiar_target_x, global.familiar_target_y, "Instances", obj_familiar_appear);
            fx.image_xscale = 0.75;
            fx.image_yscale = 0.75;

            x = global.familiar_target_x;
            y = global.familiar_target_y;
            hspeed = 0;
            vspeed = 0;

            global.familiar_mode = 2;
        }

        apply_horizontal = false;
    }

    // --- Locked mode ---
    else if (global.familiar_mode == 2) {
        hspeed = 0;

        if (y > room_height + 100) {
            var fx = instance_create_layer(obj_Player.x, obj_Player.y, "Instances", obj_familiar_appear);
            x = obj_Player.x;
            y = obj_Player.y;
        }

        apply_horizontal = false;
    }

    // --- Follow mode ---
    else {
        var dist = point_distance(x, y, obj_Player.x, obj_Player.y);
        if (dist > 400) {
            var fx = instance_create_layer(obj_Player.x, obj_Player.y, "Instances", obj_familiar_appear);
            x = obj_Player.x;
            y = obj_Player.y;
            hspeed = 0;
            vspeed = 0;
        }

        // Follow logic
        follow_timer += 1;
        if (follow_timer > 30) {
            follow_distance = 20 + irandom_range(1, 10);
            follow_timer = 0;
        }

        var target_x = obj_Player.x - (obj_Player.image_xscale * follow_distance);
        var dx = target_x - x;

        hspeed = (abs(dx) > 4) ? 1.5 * sign(dx) : 0;
    }

    // --- Apply gravity ---
    if (!place_meeting(x, y + gravity_flip, obj_CollisionTiles)) {
        vspeed += gravity_force * gravity_flip;
        if (abs(vspeed) > fall_max_speed) {
            vspeed = fall_max_speed * gravity_flip;
        }
    } else if (sign(vspeed) == sign(gravity_flip)) {
        vspeed = 0;
    }

    // --- Horizontal Collision ---
    if (apply_horizontal && place_meeting(x + hspeed, y, obj_CollisionTiles)) {
        while (!place_meeting(x + sign(hspeed), y, obj_CollisionTiles)) {
            x += sign(hspeed);
        }
        hspeed = 0;
    }
    x += hspeed;

    // --- Vertical Collision ---
    if (place_meeting(x, y + vspeed, obj_CollisionTiles)) {
        while (!place_meeting(x, y + sign(vspeed), obj_CollisionTiles)) {
            y += sign(vspeed);
        }
        vspeed = 0;
    } else {
        y += vspeed;
    }
}

if (sprite_index == -1) {
    sprite_index = spr_CollisionTileTest;
}

visible = true;
image_alpha = 1;
image_blend = c_white;
depth = -10000;
