function scr_load_section(section_index) {
    // === Load Platforms (CollisionTiles) ===
    if (global.section_platforms[? section_index] != undefined) {
        var platform_data = global.section_platforms[section_index];
        for (var i = 0; i < array_length(platform_data); i++) {
            var entry = platform_data[i];
            var obj_name = entry[0];
            var xx = entry[1];
            var yy = entry[2];
            var xscale = entry[3];
            var yscale = entry[4];
            var angle = entry[5];

            var obj_id = asset_get_index(obj_name);
            if (obj_id != -1) {
                var inst = instance_create_layer(xx, yy, "Instances", obj_id);
                inst.image_xscale = xscale;
                inst.image_yscale = yscale;
                inst.image_angle = angle;
            } else {
                show_debug_message("⚠️ Could not find object: " + obj_name);
            }
        }
    }

    // === Load Game Objects (Slimes, Levers, etc) ===
    if (global.section_objects[? section_index] != undefined) {
        var object_data = global.section_objects[section_index];
        for (var j = 0; j < array_length(object_data); j++) {
            var entry = object_data[j];
            var obj_name = entry[0];
            var xx = entry[1];
            var yy = entry[2];
            var xscale = entry[3];
            var yscale = entry[4];
            var angle = entry[5];

            var obj_id = asset_get_index(obj_name);
            if (obj_id != -1) {
                var inst = instance_create_layer(xx, yy, "Instances", obj_id);
                inst.image_xscale = xscale;
                inst.image_yscale = yscale;
                inst.image_angle = angle;
            } else {
                show_debug_message("⚠️ Could not find object: " + obj_name);
            }
        }
    }
}
