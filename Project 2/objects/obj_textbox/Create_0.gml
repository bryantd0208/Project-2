// Textbox setup
current_text = "";
text_index = 0;
visible = false;
dialogue_lines = [];
char_index = 0; // How many letters to show (typewriter effect optional)
char_speed = 2; // Speed at which letters appear
char_timer = 0;
portrait_sprite = -1; // No portrait initially
target_y = 0;      // Where the box *wants* to end up
current_y = room_height + 50; // Off-screen to start
slide_speed = 0.1; // How fast to slide (0.1 = smooth, 0.2 = faster)
