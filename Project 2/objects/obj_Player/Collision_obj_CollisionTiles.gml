// If colliding while falling (landing on ground)
if (vspeed > 0) {
    vspeed = 0;
}

// If colliding while rising (hitting ceiling)
if (vspeed < 0) {
    vspeed = 1; // Bounce downward slightly
}
