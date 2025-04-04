
var moving = false

if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    image_xscale = 1
	hspeed = -player_speed
    moving = true
}
if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    image_xscale = -1
	hspeed = player_speed
    moving = true
}
if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
	vspeed = -player_speed
    moving = true
	gravity = 0.1
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
    player_speed = 0 // **Stops movement if no keys are pressed**
}


