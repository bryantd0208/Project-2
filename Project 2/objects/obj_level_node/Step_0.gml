// For optional circle "pop in"
if (draw_progress < 1) {
    draw_progress += 0.02;
    if (draw_progress > 1) draw_progress = 1;
}

// Animate line growing ONLY if there is a new level being unlocked
if (newly_unlocked_level != -1) {
    if (line_reveal_progress < 1) {
        line_reveal_progress += 1 / 120; // 2 seconds at 60fps
        if (line_reveal_progress >= 1) {
            line_reveal_progress = 1;
            newly_unlocked_level = -1; // <- Done animating
        }
    }
}
