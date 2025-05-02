if (instance_exists(obj_Player)) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();

    // === PORTRAIT ===
    var portrait_display_width = 128;
    var portrait_display_height = 64;
    var portrait_margin = 20;

    var portrait_draw_x = portrait_margin;
    var portrait_draw_y = portrait_margin;

    var portrait_scale_x = portrait_display_width / 2048;
    var portrait_scale_y = portrait_display_height / 1024;

    draw_sprite_part_ext(
        spr_zero_text, 0,
        0, 0, 2048, 1024,
        portrait_draw_x, portrait_draw_y,
        portrait_scale_x, portrait_scale_y,
        c_white, 1
    );

// === HEALTH BAR ===
var bar_width = 200;
var bar_height = 20;
var bar_x = portrait_draw_x + portrait_display_width + 20;
var bar_y = portrait_draw_y + (portrait_display_height / 2) - (bar_height / 2);

var hp_percent = clamp(obj_Player.current_health / obj_Player.max_health, 0, 1);

draw_set_color(c_gray);
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);

if (hp_percent > 0.75) {
    draw_set_color(c_lime);
} else if (hp_percent > 0.4) {
    draw_set_color(c_yellow);
} else {
    draw_set_color(c_red);
}

draw_rectangle(bar_x, bar_y, bar_x + (bar_width * hp_percent), bar_y + bar_height, false);

draw_set_color(c_black);
draw_rectangle(bar_x - 1, bar_y - 1, bar_x + bar_width + 1, bar_y + bar_height + 1, true);

// Text centered vertically and horizontally
draw_set_font(fnt_ui);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(bar_x + bar_width / 2, bar_y + bar_height / 2,
    string(floor(obj_Player.current_health)) + "/" + string(obj_Player.max_health));

if (global.show_minimap) {
    // === MINIMAP ===
    var minimap_width = 200;
    var minimap_height = 150;
    var minimap_margin = 20;

    var minimap_x = gui_w - minimap_width - minimap_margin;
    var minimap_y = minimap_margin;

    draw_set_color(c_black);
    draw_rectangle(minimap_x - 2, minimap_y - 2, minimap_x + minimap_width + 2, minimap_y + minimap_height + 2, true);

    draw_set_color(c_dkgray);
    draw_rectangle(minimap_x, minimap_y, minimap_x + minimap_width, minimap_y + minimap_height, false);

    var world_width = room_width;
    var world_height = room_height;

    // --- PLATFORM DOTS ---
    with (obj_CollisionTiles) {
        var left = bbox_left / world_width * minimap_width;
        var top = bbox_top / world_height * minimap_height;
        var right = bbox_right / world_width * minimap_width;
        var bottom = bbox_bottom / world_height * minimap_height;

        if (right >= 0 && left <= minimap_width && bottom >= 0 && top <= minimap_height) {
            left = clamp(left, 0, minimap_width);
            top = clamp(top, 0, minimap_height);
            right = clamp(right, 0, minimap_width);
            bottom = clamp(bottom, 0, minimap_height);

            draw_set_color(c_white);
            draw_rectangle(minimap_x + left, minimap_y + top, minimap_x + right, minimap_y + bottom, false);
        }
    }

    // --- PLAYER DOT ---
    var px = obj_Player.x / world_width * minimap_width;
    var py = obj_Player.y / world_height * minimap_height;
    if (px >= 0 && px <= minimap_width && py >= 0 && py <= minimap_height) {
        draw_set_color(c_lime);
        draw_circle(minimap_x + px, minimap_y + py, 3, false);
    }

    // --- ENEMY DOTS ---
    with (obj_enemy) {
        var mx = x / world_width * minimap_width;
        var my = y / world_height * minimap_height;
        if (mx >= 0 && mx <= minimap_width && my >= 0 && my <= minimap_height) {
            draw_set_color(c_red);
            draw_circle(minimap_x + mx, minimap_y + my, 2, false);
        }
    }

    // --- FAMILIAR DOT ---
    with (obj_familiar) {
        var fx = x / world_width * minimap_width;
        var fy = y / world_height * minimap_height;
        if (fx >= 0 && fx <= minimap_width && fy >= 0 && fy <= minimap_height) {
            draw_set_color(c_aqua);
            draw_circle(minimap_x + fx, minimap_y + fy, 2, false);
        }
    }
}
}

// === FADE / LEVER MESSAGE ===
if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
}

if (global.show_lever_message) {
    var remaining = global.total_levers - global.levers_flipped;
    var message = "Levers remaining: " + string(remaining);

    draw_set_font(fnt_ui);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2 - 100, message);
}

var time_str = string(floor(global.level_timer));

draw_set_font(fnt_ui);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(display_get_gui_width() / 2, 40, time_str);
