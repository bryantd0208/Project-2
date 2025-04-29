// Only damage if we haven't hit this enemy yet
if (ds_list_find_index(already_hit, other.id) == -1) {
    ds_list_add(already_hit, other.id);

    var damage = 40;
    var knockback_direction = (image_xscale == -1) ? 180 : 0;

    if (other.enemy_hp > 0) {
        scr_damage(other, damage, knockback_direction);
    }
}


function scr_damage(enemy_instance, damage, knockback_direction) {
    with (enemy_instance) {
        enemy_hp -= damage;
		show_debug_message(enemy_hp);
        var knockback_speed = 4; // Or whatever you want
        hspeed = lengthdir_x(knockback_speed, knockback_direction);
        vspeed = lengthdir_y(knockback_speed, knockback_direction);

        if (enemy_hp <= 0) {
            instance_destroy();
        }
    }
}
