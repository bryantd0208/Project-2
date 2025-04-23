// Only damage if we haven't hit this enemy yet
if (!ds_list_find_index(already_hit, other.id) >= 0) {
    ds_list_add(already_hit, other.id);

    var damage = 30;
    var knockback_direction = (image_xscale == -1) ? 180 : 0;

    if (other.enemy_hp > 0) {
        scr_damage(other, damage, knockback_direction);
    }
}



function scr_damage(enemy_instance, damage, knockback_direction) {
    with (enemy_instance) {
        enemy_hp -= damage;

        hspeed = lengthdir_x(knockback_speed, knockback_direction);
        vspeed = lengthdir_y(knockback_speed, knockback_direction);

        if (enemy_hp <= 0) {
            instance_destroy();
        }
    }
}
