/// scr_update_music()
if (room != last_room) {
    if (room == rm_MainMenu || room == rm_LevelSelect) {
        if (global.current_music != snd_title_music) {
            if (audio_is_playing(global.current_bgm)) {
                audio_stop_sound(global.current_bgm);
            }
            global.current_bgm = audio_play_sound(snd_title_music, 1, true);
            audio_sound_gain(global.current_bgm, 0.1, 0); 
            global.current_music = snd_title_music;
        }
    } else {
        if (global.current_music != snd_background_music) {
            if (audio_is_playing(global.current_bgm)) {
                audio_stop_sound(global.current_bgm);
            }
            global.current_bgm = audio_play_sound(snd_background_music, 1, true);
            audio_sound_gain(global.current_bgm, 0.1, 0); 
            global.current_music = snd_background_music;
        }
    }

    last_room = room;
}
