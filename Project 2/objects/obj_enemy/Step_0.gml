// --- Create Event ---
attack_cooldown = 0;
attack_range = 150;
attack_speed = 90;
move_speed = 0; // <-- Parent doesn't move on its own
can_attack = true; // <-- Some enemies might not attack, so this is flexible

// --- Step Event ---
var player = instance_nearest(x, y, obj_Player);

if (player != noone) {
    var dist_to_player = point_distance(x, y, player.x, player.y);

    // Face player
    if (player.x < x) {
        image_xscale = -1;
    }
    else {
        image_xscale = 1;
    }

    // --- Move toward player if you want (for walking enemies) ---
    // (Parent does not move; children can override)

    // --- Attack ---
    if (can_attack && dist_to_player < attack_range) {
        if (attack_cooldown <= 0) {
            perform_attack();
            attack_cooldown = attack_speed;
        }
    }
}

// --- Attack Cooldown ---
if (attack_cooldown > 0) {
    attack_cooldown -= 1;
}

// --- Script: Default Attack ---
function perform_attack() {
    var slash_offset = 12;
    var slash_x = x + (image_xscale * slash_offset);
    var slash_y = y;
    
    var slash = instance_create_layer(slash_x, slash_y, "Instances", obj_enemy_slash);
    slash.direction = (image_xscale == -1) ? 180 : 0;
    slash.image_xscale = image_xscale;
}
