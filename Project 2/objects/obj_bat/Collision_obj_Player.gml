if (bat_state == BatState.CHARGE && can_attack) {
    with (other) {
        current_health -= 10;
        show_debug_message(current_health);
    }

    can_attack = false;
    bat_state = BatState.RETREAT;
    cooldown_timer = room_speed * 3; // 3 seconds before next attack
}

