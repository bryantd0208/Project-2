// --- INPUT ---
var move_x = 0;
var move_y = 0;

// --- LEFT / RIGHT movement input ---
if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    move_x = -player_speed;
    image_xscale = -1;
}
else if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    move_x = player_speed;
    image_xscale = 1;
}

// --- CLIMBING CHECK ---
if (instance_place(x, y + 1, obj_ladder)) {
    if (keyboard_check(vk_up) || keyboard_check(vk_down)) {
        climbing = true;
        gravity_force = 0;
        sprite_index = spr_climbing;
    }
}
else {
    climbing = false;
    sprite_index = spr_player;
}

// --- MOVEMENT ---
if (climbing) {
    vspeed = 0;

    if (keyboard_check(vk_up)) {
        move_y = -climb_speed;
    }
    if (keyboard_check(vk_down)) {
        move_y = climb_speed;
    }
}
else {
    // --- JUMPING ---
    if ((keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) && instance_place(x, y + 1, obj_CollisionTiles)) {
        vspeed = -jump_force;
    }

    // --- GRAVITY ---
    if (instance_place(x, y + 1, obj_CollisionTiles)) {
        gravity_force = 0;
    } else {
        gravity_force = 0.3;
    }

    vspeed += gravity_force;
    if (vspeed > fall_max_speed) {
        vspeed = fall_max_speed;
    }

    move_y = vspeed;
}

// --- COLLISIONS ---

// Horizontal movement (simple)
if (!place_meeting(x + move_x, y, obj_CollisionTiles)) {
    x += move_x;
} else {
    move_x = 0;
}

// Vertical movement (simple)
if (!place_meeting(x, y + move_y, obj_CollisionTiles)) {
    y += move_y;
} else {
    vspeed = 0;
}

// --- ATTACK (OPTIONAL) ---
if (keyboard_check_pressed(vk_space)) {
    instance_create_layer(x, y, "Instances", obj_sword_slash);
}
