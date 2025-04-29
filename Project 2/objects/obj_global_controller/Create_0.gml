// obj_global_controller Create Event

global.current_level = 1; // 🔥 Now it's truly global
global.levels_unlocked = [1]; // 🔥 Now it's truly global
global.player_lives = 3;
global.background_sprites = [];

if (!variable_global_exists("game_won")) global.game_won = false;
if (!variable_global_exists("game_lost")) global.game_lost = false;
if (!variable_global_exists("show_pause_menu")) {
    global.show_pause_menu = false;
}

// Familiar teleport system globals
global.familiar_mode = 0; // 0 = follow, 1 = target mode, 2 = locked in place
global.familiar_target_x = 0;
global.familiar_target_y = 0;


global.section_platforms = ds_map_create();
// Section 1
global.section_platforms[0] = [
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
// Section 2
global.section_platforms[1] = [
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
// Section 3
global.section_platforms[2] = [
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

global.section_objects = ds_map_create();
