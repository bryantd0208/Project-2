// --- HORIZONTAL MOVEMENT INPUT ---
var moving = false;

if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    image_xscale = -1;
    hspeed = -player_speed;
    moving = true;
}
else if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    image_xscale = 1;
    hspeed = player_speed;
    moving = true;
}
else {
    hspeed = 0;
}

// --- JUMP INPUT ---
var ground_check_offset = gravity_flip;

if ((keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")))) {
    if (place_meeting(x, y + ground_check_offset, obj_CollisionTiles)) {
        vspeed = -jump_force * gravity_flip;
    }
    else if (wall_slide) {
        // Wall jump off the wall!
        vspeed = -wall_jump_v_force * gravity_flip;
        hspeed = -wall_dir * wall_jump_h_force; // Push opposite from wall
        wall_slide = false; // No longer sticking
    }
}


// --- SHORT HOP CONTROL ---
if (vspeed * gravity_flip < 0) { // Rising
    if (!(keyboard_check(vk_up) || keyboard_check(ord("W")))) {
        var max_short_hop_vspeed = 2.5;
        if (abs(vspeed) > max_short_hop_vspeed) {
            vspeed = -max_short_hop_vspeed * gravity_flip;
        }
    }
}



// --- UPDATE STATE ---
if (!moving) {
    player_state = PlayerState.IDLE;
} else {
    if (keyboard_check(vk_shift)) {
        player_speed = run_speed;
        player_state = PlayerState.RUNNING;
    } else {
        player_speed = base_speed;
        player_state = PlayerState.WALKING;
    }
}

// --- HORIZONTAL COLLISION ---
wall_slide = false;
wall_dir = 0;

if (place_meeting(x + hspeed, y, obj_CollisionTiles)) {
    if (hspeed != 0) {
        wall_slide = true;
        wall_dir = sign(hspeed);
    }
    hspeed = 0;
}

// 🔥 NEW DEBUG
if (wall_slide) {
    show_debug_message("Wall sliding! Grounded = " + string(grounded));
}



// --- VERTICAL COLLISION ---
if (place_meeting(x, y + vspeed, obj_CollisionTiles)) {
    var sign_v = sign(vspeed);
    while (!place_meeting(x, y + sign_v, obj_CollisionTiles)) {
        y += sign_v;
    }
    vspeed = 0;
} else {
    // --- Landing forgiveness: if very close to ground, snap ---
    if (abs(vspeed) < 1 && place_meeting(x, y + sign(gravity_flip), obj_CollisionTiles)) {
        while (!place_meeting(x, y + sign(gravity_flip), obj_CollisionTiles)) {
            y += sign(gravity_flip);
        }
        vspeed = 0;
    }
    else {
        y += vspeed;
    }
}


// --- APPLY HORIZONTAL MOVEMENT ---
x += hspeed;

// --- GROUND CHECK ---
grounded = place_meeting(x, y + gravity_flip, obj_CollisionTiles);

// --- GLOBAL HIT FREEZE ---
if (global.hit_freeze_timer > 0) {
    global.hit_freeze_timer -= 1;
    exit;
}

// --- DAMAGE HANDLING ---
if (player_state == PlayerState.DAMAGED) {
    if (!damage_taken) {
        current_health -= 30;
        damage_taken = true;
        show_debug_message("Player took damage! HP: " + string(current_health));
    }

    damage_timer += 1;

    hspeed = lerp(hspeed, knockback_target_hspeed, 0.25);
    vspeed = lerp(vspeed, knockback_target_vspeed, 0.25);

    if (damage_timer > 10) {
        damage_timer = 0;
        player_state = PlayerState.IDLE;
        hspeed = 0;
        vspeed = 0;
        knockback_target_hspeed = 0;
        knockback_target_vspeed = 0;
        damage_taken = false;
    }
}

// --- STATE INPUT CHECK (DEFEND, ATTACK) ---
if (player_state != PlayerState.DAMAGED) {
    // --- DEFENDING ---
    if (keyboard_check(vk_control)) {
        player_state = PlayerState.DEFENDING;
    }
    // --- ATTACKING ---
    else if (keyboard_check_pressed(vk_space)) {
        if (player_state != PlayerState.DEFENDING) {
            player_state = PlayerState.ATTACKING;

            var slash_offset = 32;
            var slash_x = x + (image_xscale * slash_offset);
            var slash_y = y;

            var slash = instance_create_layer(slash_x, slash_y, "Instances", obj_sword_slash);

            if (image_xscale == -1) {
                slash.direction = 180;
                slash.image_xscale = -1;
            } else {
                slash.direction = 0;
                slash.image_xscale = 1;
            }
        }
    }
}

// --- GRAVITY FLIP CHECK ---
if (keyboard_check_pressed(ord("G")) && !global.gravity_flipping) {
    scr_gravity_flip();
}
if (global.gravity_flipping) {
    scr_gravity_flip();
}

// --- STORY START (Escape) ---
if (keyboard_check(vk_escape)) {
    var story = [
        "Once upon a time, a raccoon cleaned the world...",
        "He faced many dangers and obstacles ahead.",
        "But with courage, he continued forward."
    ];
    scr_start_dialogue(story, spr_zero_text);
}

// --- LOSS CONDITION ---
if (current_health <= 0 && !global.game_lost) {
    global.game_lost = true;
    room_goto(rm_Lose);
}

// --- APPLY GRAVITY and WALL SLIDE ---
if (!grounded) {
    vspeed += gravity_force * gravity_flip; // Gravity always applies

    if (wall_slide) {
        // Limit fall speed while sliding
        if (vspeed * gravity_flip > wall_slide_speed) {
            vspeed = wall_slide_speed * gravity_flip;
        }
    }
} else {
    // Snap to 0 when grounded
    if (sign(vspeed) == sign(gravity_flip)) {
        vspeed = 0;
    }
}
