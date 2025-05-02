// obj_global_controller Create Event

// --- Game State Initialization ---
global.current_level = 1;
global.levels_unlocked = [1];
global.player_lives = 3;
global.background_sprites = [];

global.game_won = variable_global_exists("game_won") ? global.game_won : false;
global.game_lost = variable_global_exists("game_lost") ? global.game_lost : false;
global.show_pause_menu = variable_global_exists("show_pause_menu") ? global.show_pause_menu : false;

global.familiar_mode = 0; // 0 = follow, 1 = target mode, 2 = locked in place
global.familiar_target_x = 0;
global.familiar_target_y = 0;

// --- Master Level Map ---
global.levels = ds_map_create();

// --- Build Level 1 Sections ---
var level1 = ds_map_create();

for (var section_index = 0; section_index < 3; section_index++) {
    var section = ds_map_create();

    // Platforms per section
    var platforms = []; // Fill manually or via external data later
    // Objects per section
    var objects = []; // Fill manually or via external data later

    switch (section_index) {
        case 0:
            platforms = [
    ["obj_CollisionTiles",384,896,1,1,0],["obj_CollisionTiles",352,896,1,1,0],["obj_CollisionTiles",320,896,1,1,0],["obj_CollisionTiles",288,896,1,1,0],
    ["obj_CollisionTiles",256,896,1,1,0],["obj_CollisionTiles",224,896,1,1,0],["obj_CollisionTiles",192,896,1,1,0],["obj_CollisionTiles",160,896,1,1,0],
    ["obj_CollisionTiles",128,896,1,1,0],["obj_CollisionTiles",96,896,1,1,0],["obj_CollisionTiles",64,896,1,1,0],["obj_CollisionTiles",32,896,1,1,0],
    ["obj_CollisionTiles",1872,400,1,1,0],["obj_CollisionTiles",1840,400,1,1,0],["obj_CollisionTiles",1808,400,1,1,0],
    ["obj_CollisionTiles",1744,464,1,1,0],["obj_CollisionTiles",1712,464,1,1,0],["obj_CollisionTiles",1680,464,1,1,0],["obj_CollisionTiles",1648,464,1,1,0],
    ["obj_CollisionTiles",1296,288,1,1,0],["obj_CollisionTiles",1328,288,1,1,0],["obj_CollisionTiles",1360,288,1,1,0],["obj_CollisionTiles",1392,288,1,1,0],
    ["obj_CollisionTiles",1520,288,1,1,0],["obj_CollisionTiles",1488,288,1,1,0],["obj_CollisionTiles",1952,128,1,1,0],["obj_CollisionTiles",1920,128,1,1,0],
    ["obj_CollisionTiles",1888,128,1,1,0],["obj_CollisionTiles",1856,128,1,1,0],["obj_CollisionTiles",1824,128,1,1,0],["obj_CollisionTiles",1792,128,1,1,0],
    ["obj_CollisionTiles",1760,128,1,1,0],["obj_CollisionTiles",1728,128,1,1,0],["obj_CollisionTiles",1696,128,1,1,0],["obj_CollisionTiles",1664,128,1,1,0],
    ["obj_CollisionTiles",1632,128,1,1,0],["obj_CollisionTiles",1600,128,1,1,0],["obj_CollisionTiles",1568,128,1,1,0],["obj_CollisionTiles",1536,128,1,1,0],
    ["obj_CollisionTiles",1504,128,1,1,0],["obj_CollisionTiles",1472,128,1,1,0],["obj_CollisionTiles",1392,112,1,1,0],["obj_CollisionTiles",1360,112,1,1,0],
    ["obj_CollisionTiles",1328,112,1,1,0],["obj_CollisionTiles",1296,112,1,1,0],["obj_CollisionTiles",1136,224,1,1,0],["obj_CollisionTiles",1168,224,1,1,0],
    ["obj_CollisionTiles",1200,224,1,1,0],["obj_CollisionTiles",1472,288,1,1,0],["obj_CollisionTiles",1440,288,1,1,0],["obj_CollisionTiles",1408,288,1,1,0],
    ["obj_CollisionTiles",1696,288,1,1,0],["obj_CollisionTiles",1664,288,1,1,0],["obj_CollisionTiles",1632,288,1,1,0],["obj_CollisionTiles",1520,480,1,1,0],
    ["obj_CollisionTiles",1488,480,1,1,0],["obj_CollisionTiles",1456,480,1,1,0],["obj_CollisionTiles",1424,480,1,1,0],["obj_CollisionTiles",1280,487,1,1,0],
    ["obj_CollisionTiles",1248,487,1,1,0],["obj_CollisionTiles",1216,487,1,1,0],["obj_CollisionTiles",1072,510,1,1,0],["obj_CollisionTiles",1040,510,1,1,0],
    ["obj_CollisionTiles",1008,510,1,1,0],["obj_CollisionTiles",976,510,1,1,0],["obj_CollisionTiles",944,510,1,1,0],["obj_CollisionTiles",912,510,1,1,0],
    ["obj_CollisionTiles",880,510,1,1,0],["obj_CollisionTiles",848,510,1,1,0],["obj_CollisionTiles",388,316,1,1,0],["obj_CollisionTiles",368,316,1,1,0],
    ["obj_CollisionTiles",336,316,1,1,0],["obj_CollisionTiles",304,316,1,1,0],["obj_CollisionTiles",176,272,1,1,0],["obj_CollisionTiles",144,272,1,1,0],
    ["obj_CollisionTiles",112,272,1,1,0],["obj_CollisionTiles",553,349,1,1,0],["obj_CollisionTiles",521,349,1,1,0],["obj_CollisionTiles",489,349,1,1,0],
    ["obj_CollisionTiles",464,349,1,1,0],["obj_CollisionTiles",777,415,1,1,0],["obj_CollisionTiles",745,415,1,1,0],["obj_CollisionTiles",713,415,1,1,0],
    ["obj_CollisionTiles",688,415,1,1,0],["obj_CollisionTiles",624,519,1,1,0],["obj_CollisionTiles",592,519,1,1,0],["obj_CollisionTiles",560,519,1,1,0],
    ["obj_CollisionTiles",416,519,1,1,0],["obj_CollisionTiles",384,519,1,1,0],["obj_CollisionTiles",352,519,1,1,0],["obj_CollisionTiles",320,519,1,1,0],
    ["obj_CollisionTiles",181,576,1,1,0],["obj_CollisionTiles",150,576,1,1,0],["obj_CollisionTiles",120,576,1,1,0],["obj_CollisionTiles",89,576,1,1,0],
    ["obj_CollisionTiles",384,704,1,1,0],["obj_CollisionTiles",352,704,1,1,0],["obj_CollisionTiles",320,704,1,1,0],["obj_CollisionTiles",288,704,1,1,0],
    ["obj_CollisionTiles",256,704,1,1,0],["obj_CollisionTiles",224,704,1,1,0],["obj_CollisionTiles",192,704,1,1,0],["obj_CollisionTiles",160,704,1,1,0],
    ["obj_CollisionTiles",128,704,1,1,0],["obj_CollisionTiles",96,704,1,1,0],["obj_CollisionTiles",64,704,1,1,0],["obj_CollisionTiles",32,704,1,1,0],
    ["obj_CollisionTiles",722,800,1,1,0],["obj_CollisionTiles",704,800,1,1,0],["obj_CollisionTiles",672,800,1,1,0],["obj_CollisionTiles",640,800,1,1,0],
    ["obj_CollisionTiles",608,800,1,1,0],["obj_CollisionTiles",576,800,1,1,0],["obj_CollisionTiles",544,800,1,1,0],["obj_CollisionTiles",512,800,1,1,0],
    ["obj_CollisionTiles",1888,704,1,1,0],["obj_CollisionTiles",1856,704,1,1,0],["obj_CollisionTiles",1824,704,1,1,0],["obj_CollisionTiles",1792,704,1,1,0],
    ["obj_CollisionTiles",1760,704,1,1,0],["obj_CollisionTiles",1728,704,1,1,0],["obj_CollisionTiles",1696,704,1,1,0],["obj_CollisionTiles",1664,704,1,1,0],
    ["obj_CollisionTiles",1632,704,1,1,0],["obj_CollisionTiles",1568,800,1,1,0],["obj_CollisionTiles",1536,800,1,1,0],["obj_CollisionTiles",1504,800,1,1,0],
    ["obj_CollisionTiles",1472,800,1,1,0],["obj_CollisionTiles",1440,800,1,1,0],["obj_CollisionTiles",1408,800,1,1,0],["obj_CollisionTiles",1376,800,1,1,0],
    ["obj_CollisionTiles",1344,800,1,1,0],["obj_CollisionTiles",1312,800,1,1,0],["obj_CollisionTiles",1280,800,1,1,0],["obj_CollisionTiles",1248,800,1,1,0],
    ["obj_CollisionTiles",1216,800,1,1,0],["obj_CollisionTiles",768,928,1,1,0],["obj_CollisionTiles",1152,928,1,1,0],["obj_CollisionTiles",1120,928,1,1,0],
    ["obj_CollisionTiles",1088,928,1,1,0],["obj_CollisionTiles",1056,928,1,1,0],["obj_CollisionTiles",1024,928,1,1,0],["obj_CollisionTiles",992,928,1,1,0],
    ["obj_CollisionTiles",960,928,1,1,0],["obj_CollisionTiles",928,928,1,1,0],["obj_CollisionTiles",896,928,1,1,0],["obj_CollisionTiles",864,928,1,1,0],
    ["obj_CollisionTiles",832,928,1,1,0],["obj_CollisionTiles",800,928,1,1,0],["obj_CollisionTiles",704,992,1,1,0],["obj_CollisionTiles",672,992,1,1,0],
    ["obj_CollisionTiles",640,992,1,1,0],["obj_CollisionTiles",608,992,1,1,0],["obj_CollisionTiles",576,992,1,1,0],["obj_CollisionTiles",544,992,1,1,0],
    ["obj_CollisionTiles",512,992,1,1,0],["obj_CollisionTiles",480,992,1,1,0],["obj_CollisionTiles",448,992,1,1,0]
			];
            objects = [
    ["obj_slime", 224, 689.5, 1, 1, 0],
    ["obj_slime", 1408, 273.5, 1, 1, 0],
    ["obj_slime", 1696, 113.2, 1, 1, 0],
    ["obj_slime", 960, 495.4, 1, 1, 0],
    ["obj_slime", 1376, 785.5, 1, 1, 0],
    ["obj_slime", 576, 977.5, 1, 1, 0],
    ["obj_Switch", 128, 240, 1, 1, 0, 3, 0],
    ["obj_Switch", 64, 667, 1, 1, 0, 2, 0],
    ["obj_Switch", 1823, 667, 1, 1, 0, 1, 0]
];
            break;
        case 1:
            platforms = [
    ["obj_CollisionTiles",1952,704,1,1,0],["obj_CollisionTiles",1920,704,1,1,0],["obj_CollisionTiles",1296,583,1,1,0],["obj_CollisionTiles",1264,583,1,1,0],
    ["obj_CollisionTiles",1232,583,1,1,0],["obj_CollisionTiles",1072,612,1,1,0],["obj_CollisionTiles",1040,612,1,1,0],["obj_CollisionTiles",1008,612,1,1,0],
    ["obj_CollisionTiles",976,612,1,1,0],["obj_CollisionTiles",944,612,1,1,0],["obj_CollisionTiles",912,612,1,1,0],["obj_CollisionTiles",880,612,1,1,0],
    ["obj_CollisionTiles",848,612,1,1,0],["obj_CollisionTiles",1456,144,1,1,0],["obj_CollisionTiles",1424,144,1,1,0],["obj_CollisionTiles",1392,144,1,1,0],
    ["obj_CollisionTiles",1712,126,1,1,0],["obj_CollisionTiles",1680,126,1,1,0],["obj_CollisionTiles",1648,126,1,1,0],["obj_CollisionTiles",1616,126,1,1,0],
    ["obj_CollisionTiles",944,288,1,1,0],["obj_CollisionTiles",976,288,1,1,0],["obj_CollisionTiles",1008,288,1,1,0],["obj_CollisionTiles",1040,288,1,1,0],
    ["obj_CollisionTiles",1168,288,1,1,0],["obj_CollisionTiles",1136,288,1,1,0],["obj_CollisionTiles",432,128,1,1,0],["obj_CollisionTiles",400,128,1,1,0],
    ["obj_CollisionTiles",368,128,1,1,0],["obj_CollisionTiles",336,128,1,1,0],["obj_CollisionTiles",304,128,1,1,0],["obj_CollisionTiles",272,128,1,1,0],
    ["obj_CollisionTiles",240,128,1,1,0],["obj_CollisionTiles",208,128,1,1,0],["obj_CollisionTiles",176,128,1,1,0],["obj_CollisionTiles",144,128,1,1,0],
    ["obj_CollisionTiles",112,128,1,1,0],["obj_CollisionTiles",80,128,1,1,0],["obj_CollisionTiles",48,128,1,1,0],["obj_CollisionTiles",16,128,1,1,0],
    ["obj_CollisionTiles",-16,128,1,1,0],["obj_CollisionTiles",-48,128,1,1,0],["obj_CollisionTiles",784,176,1,1,0],["obj_CollisionTiles",752,176,1,1,0],
    ["obj_CollisionTiles",720,176,1,1,0],["obj_CollisionTiles",688,176,1,1,0],["obj_CollisionTiles",528,128,1,1,0],["obj_CollisionTiles",560,128,1,1,0],
    ["obj_CollisionTiles",592,128,1,1,0],["obj_CollisionTiles",1120,288,1,1,0],["obj_CollisionTiles",1088,288,1,1,0],["obj_CollisionTiles",1056,288,1,1,0],
    ["obj_CollisionTiles",1328,224,1,1,0],["obj_CollisionTiles",1296,224,1,1,0],["obj_CollisionTiles",1264,224,1,1,0],["obj_CollisionTiles",1520,480,1,1,0],
    ["obj_CollisionTiles",1488,480,1,1,0],["obj_CollisionTiles",1456,480,1,1,0],["obj_CollisionTiles",1424,480,1,1,0],["obj_CollisionTiles",1280,487,1,1,0],
    ["obj_CollisionTiles",1248,487,1,1,0],["obj_CollisionTiles",1216,487,1,1,0],["obj_CollisionTiles",1072,510,1,1,0],["obj_CollisionTiles",1040,510,1,1,0],
    ["obj_CollisionTiles",1008,510,1,1,0],["obj_CollisionTiles",976,510,1,1,0],["obj_CollisionTiles",944,510,1,1,0],["obj_CollisionTiles",912,510,1,1,0],
    ["obj_CollisionTiles",880,510,1,1,0],["obj_CollisionTiles",848,510,1,1,0],["obj_CollisionTiles",356,316,1,1,0],["obj_CollisionTiles",336,316,1,1,0],
    ["obj_CollisionTiles",304,316,1,1,0],["obj_CollisionTiles",272,316,1,1,0],["obj_CollisionTiles",176,285,1,1,0],["obj_CollisionTiles",144,285,1,1,0],
    ["obj_CollisionTiles",112,285,1,1,0],["obj_CollisionTiles",553,349,1,1,0],["obj_CollisionTiles",521,349,1,1,0],["obj_CollisionTiles",489,349,1,1,0],
    ["obj_CollisionTiles",464,349,1,1,0],["obj_CollisionTiles",777,400,1,1,0],["obj_CollisionTiles",745,400,1,1,0],["obj_CollisionTiles",713,400,1,1,0],
    ["obj_CollisionTiles",688,400,1,1,0],["obj_CollisionTiles",624,519,1,1,0],["obj_CollisionTiles",592,519,1,1,0],["obj_CollisionTiles",560,519,1,1,0],
    ["obj_CollisionTiles",416,519,1,1,0],["obj_CollisionTiles",384,519,1,1,0],["obj_CollisionTiles",352,519,1,1,0],["obj_CollisionTiles",320,519,1,1,0],
    ["obj_CollisionTiles",181,576,1,1,0],["obj_CollisionTiles",150,576,1,1,0],["obj_CollisionTiles",120,576,1,1,0],["obj_CollisionTiles",89,576,1,1,0],
    ["obj_CollisionTiles",384,704,1,1,0],["obj_CollisionTiles",352,704,1,1,0],["obj_CollisionTiles",320,704,1,1,0],["obj_CollisionTiles",288,704,1,1,0],
    ["obj_CollisionTiles",256,704,1,1,0],["obj_CollisionTiles",224,704,1,1,0],["obj_CollisionTiles",192,704,1,1,0],["obj_CollisionTiles",160,704,1,1,0],
    ["obj_CollisionTiles",128,704,1,1,0],["obj_CollisionTiles",96,704,1,1,0],["obj_CollisionTiles",64,704,1,1,0],["obj_CollisionTiles",32,704,1,1,0],
    ["obj_CollisionTiles",722,800,1,1,0],["obj_CollisionTiles",704,800,1,1,0],["obj_CollisionTiles",672,800,1,1,0],["obj_CollisionTiles",640,800,1,1,0],
    ["obj_CollisionTiles",608,800,1,1,0],["obj_CollisionTiles",576,800,1,1,0],["obj_CollisionTiles",544,800,1,1,0],["obj_CollisionTiles",512,800,1,1,0],
    ["obj_CollisionTiles",1888,704,1,1,0],["obj_CollisionTiles",1856,704,1,1,0],["obj_CollisionTiles",1824,704,1,1,0],["obj_CollisionTiles",1792,704,1,1,0],
    ["obj_CollisionTiles",1760,704,1,1,0],["obj_CollisionTiles",1728,704,1,1,0],["obj_CollisionTiles",1696,704,1,1,0],["obj_CollisionTiles",1664,704,1,1,0],
    ["obj_CollisionTiles",1632,704,1,1,0],["obj_CollisionTiles",1568,800,1,1,0],["obj_CollisionTiles",1536,800,1,1,0],["obj_CollisionTiles",1504,800,1,1,0],
    ["obj_CollisionTiles",1472,800,1,1,0],["obj_CollisionTiles",1440,800,1,1,0],["obj_CollisionTiles",1408,800,1,1,0],["obj_CollisionTiles",1376,800,1,1,0],
    ["obj_CollisionTiles",1344,800,1,1,0],["obj_CollisionTiles",1312,800,1,1,0],["obj_CollisionTiles",1280,800,1,1,0],["obj_CollisionTiles",1248,800,1,1,0],
    ["obj_CollisionTiles",1216,800,1,1,0],["obj_CollisionTiles",768,928,1,1,0],["obj_CollisionTiles",1152,928,1,1,0],["obj_CollisionTiles",1120,928,1,1,0],
    ["obj_CollisionTiles",1088,928,1,1,0],["obj_CollisionTiles",1056,928,1,1,0],["obj_CollisionTiles",1024,928,1,1,0],["obj_CollisionTiles",992,928,1,1,0],
    ["obj_CollisionTiles",960,928,1,1,0],["obj_CollisionTiles",928,928,1,1,0],["obj_CollisionTiles",896,928,1,1,0],["obj_CollisionTiles",864,928,1,1,0],
    ["obj_CollisionTiles",832,928,1,1,0],["obj_CollisionTiles",800,928,1,1,0],["obj_CollisionTiles",704,992,1,1,0],["obj_CollisionTiles",672,992,1,1,0],
    ["obj_CollisionTiles",640,992,1,1,0],["obj_CollisionTiles",608,992,1,1,0],["obj_CollisionTiles",576,992,1,1,0],["obj_CollisionTiles",544,992,1,1,0],
    ["obj_CollisionTiles",512,992,1,1,0],["obj_CollisionTiles",480,992,1,1,0],["obj_CollisionTiles",448,992,1,1,0]
];
            objects = [
    ["obj_slime", 928, 495.4, 1, 1, 0],
    ["obj_slime", 1440, 785.5, 1, 1, 0],
    ["obj_slime", 1728, 689.3, 1, 1, 0],
    ["obj_slime", 256, 689.5, 1, 1, 0],
    ["obj_slime", 1024, 273.5, 1, 1, 0],
    ["obj_bat", 736, 831.35, -1, 1, 0],
    ["obj_bat", 416, 415.98, -1, 1, 0],
    ["obj_bat", 1312, 639.55, -1, 1, 0],
    ["obj_bat", 1440, 64.55, -1, 1, 0],
    ["obj_Switch", 1280, 608, 1, 1, 0, 4, 1],
    ["obj_Switch", 992, 890, 1, 1, 0, 3, 1],
    ["obj_Switch", 1472, 440, 1, 1, 0, 2, 0],
    ["obj_Switch", 1664, 88, 1, 1, 0, 1, 1],
    ["obj_pressureplate", 96, 256, 0.6, 1, 0, 1],
    ["obj_pressureplate", 480, 960, 0.6, 1, 0, 2]
];
            break;
        case 2:
            platforms = [
    ["obj_CollisionTiles", 345, 61, 8, 1, 0],
    ["obj_CollisionTiles", 576, 160, 3, 1, 0],
    ["obj_CollisionTiles", 896, 32, 12, 1, 0],
    ["obj_CollisionTiles", 1280, 32, 3.53, 1, 0],
    ["obj_CollisionTiles", 1032, 232, 3, 1, 0],
    ["obj_CollisionTiles", 256, 384, 17, 1, 0],
    ["obj_CollisionTiles", 704, 416, 3.5, 1, 0],
    ["obj_CollisionTiles", 904, 480, 3.5, 1, 0],
    ["obj_CollisionTiles", 1088, 584, 6.5, 1, 0],
    ["obj_CollisionTiles", 1476, 576, 7, 1, 0],
    ["obj_CollisionTiles", 1807, 512, 8, 1, 0],
    ["obj_CollisionTiles", 1824, 800, 3, 1, 0],
    ["obj_CollisionTiles", 1707, 870, 3, 1, 0],
    ["obj_CollisionTiles", 1536, 960, 8, 1, 0],
    ["obj_CollisionTiles", 1216, 1030, 6.5, 1, 0],
    ["obj_CollisionTiles", 992, 896, 4, 1, 0],
    ["obj_CollisionTiles", 192, 1032, 10, 1, 0],
    ["obj_CollisionTiles", 512, 896, 3.5, 1, 0],
    ["obj_CollisionTiles", 768, 774, 6.5, 1, 0],
    ["obj_CollisionTiles", 576, 608, 3.5, 1, 0],
    ["obj_CollisionTiles", 192, 747, 14, 1, 0]
];
            objects = [
    ["obj_slime", 1536, 945.4, 1, 1, 0],
    ["obj_slime", 1472, 561.4, 1, 1, 0],
    ["obj_bat", 896, 116.07, -1, 1, 0],
    ["obj_bat", 1504, 404.2, -1, 1, 0],
    ["obj_bat", 1792, 277.11, -1, 1, 0],
    ["obj_skeleton", 1184, 987.5, -1, 1, 0],
    ["obj_skeleton", 64, 341.5, -1, 1, 0],
    ["obj_skeleton", 160, 988.8, -1, 1, 0],
    ["obj_Switch", 288, 105, 1, 1, 0, 4, 1],
    ["obj_Switch", 1024, 192, 1, 1, 0, 3, 1],
    ["obj_Switch", 1025, 56, 1, 1, 0, 2, 1],
    ["obj_Switch", 96, 992, 1, 1, 0, 1, 1],
    ["obj_pressureplate", 1408, 544, 0.6, 1, 0, 6],
    ["obj_pressureplate", 1056, 547, 1, 1, 0, 5],
    ["obj_pressureplate", 1312, 59, 0.6, 1, 0, 3],
    ["obj_pressureplate", 512, 864, 0.6, 1, 0, 1],
    ["obj_pressureplate", 1824, 768, 0.6, 1, 0, 3],
    ["obj_pressureplate", 1248, 996, 1, 1, 0, 2],
    ["obj_Door", 1824, 441, 1, 1, 0]
];
            break;
    }

    section[? "platforms"] = platforms;
    section[? "objects"] = objects;

    ds_map_add_map(level1, section_index, section);
}

// Add to global level set
ds_map_add_map(global.levels, 1, level1);

// --- Lever Tracking Setup ---
global.lever_states = ds_map_create();
global.total_levers = 0;
global.levers_flipped = 0;

for (var sec = 0; sec < ds_map_size(level1); sec++) {
    var section = level1[? sec];
    var objs = section[? "objects"];
    for (var i = 0; i < array_length(objs); i++) {
        if (objs[i][0] == "obj_Switch") {
            global.total_levers += 1;
        }
    }
}

global.unlock_rules = ds_map_create();

var sec2 = ds_map_create();
sec2[? "switch_1"] = [ ["plate", 1] ];
sec2[? "switch_3"] = [ ["plate", 2] ];
sec2[? "switch_3_result"] = [ ["gravity_flip"] ]; // flips when lever 3 is activated
sec2[? "switch_4"] = [ ["switch", 3], ["monsters_cleared"] ];
sec2[? "switch_4_result"] = [ ["gravity_flip"] ]; // <-- NEW: flip again on switch 4 activation
global.unlock_rules[? "level_1_sec_1"] = ds_map_create(); // no locks
global.unlock_rules[? "level_1_sec_2"] = sec2;

// === Section 3 unlock rules ===
var sec3 = ds_map_create();
sec3[? "switch_1"] = [ ["plate", 1] ];
sec3[? "plate_2"] = [ ["switch", 1], ["gravity_flip"] ];
sec3[? "plate_3"] = [ ["switch", 1], ["gravity_flip"] ];
sec3[? "switch_2"] = [ ["plate", 4] ];
sec3[? "switch_3"] = [ ["switch", 2], ["gravity_flip"] ];
sec3[? "switch_4"] = [ ["switch", 3], ["gravity_flip"] ];
sec3[? "door"]     = [ ["plate", 5], ["plate", 6] ];
global.unlock_rules[? "level_1_sec_3"] = sec3;
