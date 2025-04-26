// --- GROUND CHECK ---
var grounded = place_meeting(x, y + 1, obj_CollisionTiles);
// --- GLOBAL HIT FREEZE ---
if (global.hit_freeze_timer > 0) {
    global.hit_freeze_timer -= 1;
    exit; // Skip the rest of Step while frozen
}

// --- APPLY GRAVITY ---
if (!grounded) {
    gravity = 0.15;
    vspeed += gravity;
} else {
    gravity = 0;
    vspeed = 0;
}

if (player_state == PlayerState.DAMAGED) {
	if (!damage_taken) {
		current_health -= 20;
		damage_taken = true;
		show_debug_message("Player took damage! HP: " + string(current_health));
	}
	
    damage_timer += 1;

    // Smoothly LERP hspeed and vspeed toward knockback target
    hspeed = lerp(hspeed, knockback_target_hspeed, 0.25); // Smooth 25% per frame
    vspeed = lerp(vspeed, knockback_target_vspeed, 0.25);

    if (damage_timer > 10) { // 10 frames of knockback
        damage_timer = 0;
        player_state = PlayerState.IDLE;
        hspeed = 0; // stop movement clean
        vspeed = 0; // also reset bounce
        knockback_target_hspeed = 0;
        knockback_target_vspeed = 0;
		damage_taken = false;
    }
	
	// Do Damage
}


// --- STATE INPUT CHECK (DEFEND, ATTACK) ---
if (player_state != PlayerState.DAMAGED) { // Only check inputs if NOT damaged

    if (keyboard_check(vk_control)) {
        player_state = PlayerState.DEFENDING;
    }
    else if (keyboard_check_pressed(vk_space)) {
        if (player_state != PlayerState.DEFENDING) {
            player_state = PlayerState.ATTACKING;
            
            var slash_offset = 32; // Distance in front of player
            var slash_x = x + (image_xscale * slash_offset);
            var slash_y = y;
            
            var slash = instance_create_layer(slash_x, slash_y, "Instances", obj_sword_slash);
            
            // Set slash facing and flip sprite
            if (image_xscale == -1) {
                slash.direction = 180;     // face left
                slash.image_xscale = -1;    // flip slash sprite horizontally
            }
            else {
                slash.direction = 0;       // face right
                slash.image_xscale = 1;     // normal
            }
        }
    }
    else {
        // --- MOVEMENT AND STATE WHEN NOT DEFENDING OR ATTACKING ---
        var moving = false;
        
        // --- HORIZONTAL MOVEMENT ---
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
        
        // --- JUMPING ---
        if ((keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) && grounded) {
            vspeed = -6;
            moving = true;
        }
        
        // --- SHORT HOP ---
        if (vspeed < 0 && !(keyboard_check(vk_up) || keyboard_check(ord("W")))) {
            vspeed = max(vspeed, -2.5);
        }
        
        // --- SET PLAYER STATE BASED ON MOVEMENT ---
        if (!moving) {
            player_state = PlayerState.IDLE;
        }
        else if (keyboard_check(vk_shift)) {
            player_speed = run_speed;
            player_state = PlayerState.RUNNING;
        }
        else {
            player_speed = base_speed;
            player_state = PlayerState.WALKING;
        }
    }
}

// --- FALL SPEED CAP ---
var fall_max_speed = 3.5;
if (vspeed > fall_max_speed) {
    vspeed = fall_max_speed;
}

// --- COLLISION CHECKS ---
if (place_meeting(x + hspeed, y, obj_CollisionTiles)) {
    hspeed = 0;
}
if (place_meeting(x, y + vspeed, obj_CollisionTiles)) {
    vspeed = 0;
}

// --- APPLY MOVEMENT ---
x += hspeed;
y += vspeed;

// --- DEBUG (optional) ---
//show_debug_message("Grounded: " + string(grounded) + " | Hspeed: " + string(hspeed) + " | Vspeed: " + string(vspeed) + " | State: " + string(player_state));
  if (keyboard_check(vk_escape)) {		
		var story = [
		    "Once upon a time, a raccoon cleaned the world...",
		    "He faced many dangers and obstacles ahead.",
		    "But with courage, he continued forward."
		];

		// Pass the sprite you want to use (ex: spr_raccoon_portrait)
		scr_start_dialogue(story, spr_zero_text);
  }
// LOSS CONDITION
if (current_health <= 0 && !global.game_lost) {
    global.game_lost = true;
    room_goto(rm_Lose);
}

// WIN CONDITION
//if (instance_number(obj_slime) == 0 && !global.game_won) {
//    global.game_won = true;
//    room_goto(rm_Win);
//}