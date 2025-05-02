already_hit = ds_list_create();
image_speed = 12 / sprite_get_number(sprite_index);
move_speed = 4;

// Test sound trigger
if (audio_exists(snd_sword_swipe)) {
    show_debug_message("Playing sword swipe...");
    slash_sound_id = audio_play_sound(snd_sword_swipe, 1, false);
} else {
    show_debug_message("snd_sword_swipe not found!");
}
