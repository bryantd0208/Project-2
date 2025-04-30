function scr_export_level(section_index) {
    var platform_list = [];
    var object_list = [];
    var decor_list = [];

    // 🧱 Export obj_CollisionTiles as platforms
    if (object_exists(obj_CollisionTiles)) {
        with (obj_CollisionTiles) {
            var obj_name = object_get_name(object_index);
            array_push(platform_list, [obj_name, x, y, image_xscale, image_yscale, image_angle]);
        }
    }

    // 👾 Export enemies and other objects
    var enemy_types = [obj_slime, obj_bat, obj_skeleton];
    for (var e = 0; e < array_length(enemy_types); e++) {
        var type = enemy_types[e];
        if (object_exists(type)) {
            with (type) {
                var obj_name = object_get_name(object_index);
                array_push(object_list, [obj_name, x, y, image_xscale, image_yscale, image_angle]);
            }
        }
    }

var mechanics = [obj_Switch, obj_pressureplate, obj_Door];
for (var m = 0; m < array_length(mechanics); m++) {
    var mech = mechanics[m];
    if (object_exists(mech)) {
        with (mech) {
            var obj_name = object_get_name(object_index);
            var export_data = [obj_name, x, y, image_xscale, image_yscale, image_angle];

            // 🎯 Special exports based on object type
            if (object_index == obj_Switch) {
                array_push(export_data, lever_id);
                array_push(export_data, is_locked);
            }
            else if (object_index == obj_pressureplate) {
                array_push(export_data, plate_id);
            }

            array_push(object_list, export_data);
        }
    }
}




    // 📤 Export debug-friendly output
    show_debug_message("section_platforms[" + string(section_index) + "] = " + string(platform_list) + ";");
    show_debug_message("section_objects[" + string(section_index) + "] = " + string(object_list) + ";");
}
