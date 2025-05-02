if (!triggered && place_meeting(x, y, obj_Player)) {
    scr_start_dialogue(dialogue_lines, portrait_sprite);
    triggered = true; // Prevent repeat
}
