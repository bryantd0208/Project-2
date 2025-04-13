// Damage the player on collision
if (other.player_state != PlayerState.DEFENDING) {
    show_debug_message("Player hit by Slime!");
    other.hspeed = (x > other.x) ? -6 : 6; // Knock player away from slime
    other.vspeed = -2; // Knock a little upward
    other.player_state = PlayerState.DAMAGED;
    other.damage_timer = 0;
}
else {
    // If the player is blocking, maybe bounce off?
    show_debug_message("Slime hit, but player blocked!");
}
