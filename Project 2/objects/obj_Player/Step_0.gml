
var moving = false

if ((keyboard_check(vk_left) || keyboard_check(ord("A"))) and !instance_place(x - player_speed, y, obj_CollisionTiles)) {
    image_xscale = 1
	hspeed = -player_speed
    moving = true
}
if ((keyboard_check(vk_right) || keyboard_check(ord("D"))) and !instance_place(x + player_speed, y, obj_CollisionTiles)) {
    image_xscale = -1
	hspeed = player_speed
    moving = true
}
if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
	vspeed = -7
	gravity = 0.2
	moving = true
	
	// I tried to make the player stop flying, it didn't work. Fix this or delete it!
	/* if (vspeed > 12) {
		vspeed = min(vspeed, 12)
	} */
}

// **Determine Player Movement State (Only if moving)**
if (moving) {
    if (keyboard_check(vk_control)) { 
        player_speed = sneak_speed
        player_state = PlayerState.SNEAKING
    } 
    else if (keyboard_check(vk_shift)) { 
        player_speed = run_speed
        player_state = PlayerState.RUNNING
    } 
    else { 
        player_speed = base_speed
        player_state = PlayerState.WALKING
    }
} else {
	player_speed = base_speed // **Stops movement if no keys are pressed**
}

