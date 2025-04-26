function scr_gravity_flip() {
    /// scr_gravity_flip()

    if (!global.gravity_flipping) {
        global.gravity_flipping = true;
        global.gravity_flip_timer = 0;
        global.gravity_flip_duration = 20; // frames to complete flip
        global.gravity_target_scale = -sign(image_yscale); // visually flip sprite
    }

    if (global.gravity_flipping) {
        global.gravity_flip_timer += 1;
        var t = global.gravity_flip_timer / global.gravity_flip_duration;

        image_yscale = lerp(image_yscale, global.gravity_target_scale, 0.2);

        if (t >= 1) {
            image_yscale = global.gravity_target_scale;
            global.gravity_flipping = false;

            // ⚡ Flip actual gravity for physics
            gravity_flip *= -1; // <----- THE REAL MAGIC
        }
    }
}
