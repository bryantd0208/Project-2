if (audio_is_playing(slash_sound_id)) {
    audio_stop_sound(slash_sound_id);
}

ds_list_destroy(already_hit);
instance_destroy();
