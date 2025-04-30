// Move forward based on direction
x += lengthdir_x(move_speed, direction);
y += lengthdir_y(move_speed, direction);
if (sprite_index == -1) {
    sprite_index = spr_CollisionTileTest;
}

visible = true;
image_alpha = 1;
image_blend = c_white;
depth = -10000;
