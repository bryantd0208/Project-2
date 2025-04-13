// Colliding while falling (landing on ground)
if (vspeed > 0) {
    vspeed = 0;
}

// Colliding while rising (hitting ceiling)
if (vspeed < 0) {
    vspeed = 1; // Tiny bounce down
}
