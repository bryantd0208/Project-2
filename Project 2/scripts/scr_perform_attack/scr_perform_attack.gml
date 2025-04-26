function scr_perform_attack() {

	if (argument0 == SkeletonType.MELEE) {
	    var slash_offset = 12;
	    var slash_x = x + (image_xscale * slash_offset);
	    var slash_y = y;

	    var slash = instance_create_layer(slash_x, slash_y, "Instances", obj_enemy_slash);
	    slash.direction = (image_xscale == -1) ? 180 : 0;
	    slash.image_xscale = image_xscale;
	}
	else if (argument0 == SkeletonType.RANGED) {
	    var arrow = instance_create_layer(x, y, "Instances", obj_enemy_arrow);
	    arrow.direction = point_direction(x, y, obj_Player.x, obj_Player.y);
	    arrow.speed = 5;
	}

}