function scr_gravity_flip() {
    var player = instance_find(obj_Player, 0);
    if (!instance_exists(player)) exit;

    if (!global.gravity_flipping) {
        // 🚀 Small impulse away from surface instead of teleport
        player.vspeed = -3 * player.gravity_flip;

        // 🛑 Disable collisions temporarily
        player._original_mask = player.mask_index;
        player.mask_index = -1;

        // Optional: flag to disable step snapping
        player.skip_vertical_collision = true;

        global.gravity_flipping = true;
        global.gravity_flip_timer = 0;
        global.gravity_flip_duration = 20;
        global.gravity_post_buffer = 10;
        global.gravity_target_scale = -sign(player.image_yscale);
    }

    if (global.gravity_flipping) {
        global.gravity_flip_timer += 1;
        var t = global.gravity_flip_timer / global.gravity_flip_duration;

        player.image_yscale = lerp(player.image_yscale, global.gravity_target_scale, 0.2);

        if (global.gravity_flip_timer == global.gravity_flip_duration) {
            player.image_yscale = global.gravity_target_scale;
            player.gravity_flip *= -1; // ✅ Flip player-specific gravity
            show_debug_message("🌀 Gravity flipped! New direction: " + string(player.gravity_flip));
        }

        if (global.gravity_flip_timer >= global.gravity_flip_duration + global.gravity_post_buffer) {
            global.gravity_flipping = false;

            if (player._original_mask != undefined) {
                player.mask_index = player._original_mask;
                player._original_mask = undefined;
            }

            player.skip_vertical_collision = false;
        }
    }
}
