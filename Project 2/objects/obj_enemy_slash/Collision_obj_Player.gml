// Check if player is defending
if (other.player_state == PlayerState.DEFENDING) {

    var slash_from_right = (direction == 0);
    var slash_from_left = (direction == 180);

    var player_facing_right = (other.image_xscale == 1);
    var player_facing_left = (other.image_xscale == -1);

    var correct_block = (slash_from_right && player_facing_left) || (slash_from_left && player_facing_right);

    if (correct_block) {
        // --- Successful Block ---
		var story = [
		    "Once upon a time, a raccoon cleaned the world...",
		    "He faced many dangers and obstacles ahead.",
		    "But with courage, he continued forward."
		];

		// Pass the sprite you want to use (ex: spr_raccoon_portrait)
		scr_start_dialogue(story, spr_Player1);

        instance_destroy();
    }
    else {
        // --- Block Failed: Hit from Behind ---
        show_debug_message("Player Damaged (bad block or hit)!");

var knockback_strength_x = 6;
var knockback_strength_y = -2;

other.knockback_target_hspeed = lengthdir_x(knockback_strength_x, direction);
other.knockback_target_vspeed = knockback_strength_y;

other.player_state = PlayerState.DAMAGED;
other.damage_timer = 0;

instance_destroy();

    }
}
else {
    // --- Player is NOT defending ---
    show_debug_message("Player Damaged!");

    var knockback_strength_x = 6; // Stronger knockback
    var knockback_strength_y = -2; // Small bounce up

    // Apply knockback based on slash direction
    other.hspeed = lengthdir_x(knockback_strength_x, direction);
    other.vspeed = knockback_strength_y;

    other.player_state = PlayerState.DAMAGED;
    other.damage_timer = 0;
	global.hit_freeze_timer = 5; // Freeze game for 5 frames
    instance_destroy();
}
