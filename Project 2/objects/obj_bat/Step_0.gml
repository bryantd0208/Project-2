event_inherited();

var player = instance_nearest(x, y, obj_Player);

if (player != noone) {
    var dist = point_distance(x, y, player.x, player.y);
    var dir_to_player = point_direction(x, y, player.x, player.y);

    switch (bat_state) {
        case BatState.IDLE:
            if (dist < attack_range) {
                bat_state = BatState.CHARGE;
            } else {
                hover_timer += 0.1;
                hspeed = 0;
                vspeed = sin(hover_timer) * hover_height * 0.05;
            }
            break;

        case BatState.CHARGE:
            // Just move toward player - no attack here anymore
            hspeed = lengthdir_x(move_speed * 2, dir_to_player);
            vspeed = lengthdir_y(move_speed * 2, dir_to_player);
            break;

        case BatState.RETREAT:
            cooldown_timer -= 1;
            var orbit_dir = dir_to_player + 90;
            hspeed = lengthdir_x(move_speed, orbit_dir);
            vspeed = lengthdir_y(move_speed, orbit_dir);

            if (cooldown_timer <= 0) {
                bat_state = BatState.IDLE;
                can_attack = true; // Reset attack ability
            }
            break;
    }
} else {
    hspeed = 0;
    vspeed = 0;
}

// --- Apply Movement ---
x += hspeed;
y += vspeed;
