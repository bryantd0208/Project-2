timer -= 1;
if (timer <= 0) {
    // Replace this with your next level or main menu
    room_goto(rm_MainMenu); // or room_restart(), or rm_LevelSelect, etc.
}
