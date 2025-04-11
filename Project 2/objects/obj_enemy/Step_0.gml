// Find distance to player
var player = instance_nearest(x, y, obj_Player); // Find the nearest player
if (player != noone) {
    
    var dist_to_player = point_distance(x, y, player.x, player.y);
    
    // --- FACE PLAYER ---
    if (player.x < x) {
        image_xscale = -1; // Face left
    }
    else {
        image_xscale = 1;  // Face right
    }
    
    // --- ATTACK IF CLOSE ---
    if (dist_to_player < attack_range) {
        
        if (attack_cooldown <= 0) {
            // Attack
            var slash_offset = 12;
            var slash_x = x + (image_xscale * slash_offset);
            var slash_y = y;
            
            var slash = instance_create_layer(slash_x, slash_y, "Instances", obj_enemy_slash);
            
            if (image_xscale == -1) {
                slash.direction = 180;    // Left
                slash.image_xscale = -1;  // Flip slash
            }
            else {
                slash.direction = 0;      // Right
                slash.image_xscale = 1;   // Normal slash
            }
            
            attack_cooldown = attack_speed; // Reset cooldown
        }
    }
}

// --- Countdown attack cooldown ---
if (attack_cooldown > 0) {
    attack_cooldown -= 1;
}
