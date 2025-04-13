// Inherit the parent event
event_inherited();

// Skeleton movement toward player
if (instance_exists(obj_Player)) {
    var player = instance_nearest(x, y, obj_Player);
    
    if (player != noone) {
        var dir = point_direction(x, y, player.x, player.y);
        x += lengthdir_x(move_speed, dir);
        y += lengthdir_y(move_speed, dir);
    }
}
