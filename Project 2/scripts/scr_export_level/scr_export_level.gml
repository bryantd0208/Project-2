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
                array_push(object_list, [obj_name, x, y, image_xscale, image_yscale, image_angle]);
            }
        }
    }

    // 🎨 Export decoration sprites from Assets_1 layer
    if (section_index >= 0 && layer_exists("Assets_1")) {
        var asset_layer_id = layer_get_id("Assets_1");
        if (asset_layer_id != -1) {
            var asset_element_count = layer_get_element_count(asset_layer_id);

            for (var i = 0; i < asset_element_count; i++) {
                var element_id = layer_get_element_id(asset_layer_id, i);

                if (layer_get_element_type(element_id) == layerelementtype_sprite) {
                    var spr_id = layer_sprite_get_sprite(element_id);
                    var spr_name = sprite_get_name(spr_id);
                    var spr_x = layer_sprite_get_x(element_id);
                    var spr_y = layer_sprite_get_y(element_id);
                    var spr_xscale = layer_sprite_get_xscale(element_id);
                    var spr_yscale = layer_sprite_get_yscale(element_id);
                    var spr_angle = layer_sprite_get_angle(element_id);

                    array_push(decor_list, [spr_name, spr_x, spr_y, spr_xscale, spr_yscale, spr_angle]);
                }
            }
        }
    }

    // 📤 Export debug-friendly output
    show_debug_message("section_platforms[" + string(section_index) + "] = " + string(platform_list) + ";");
    show_debug_message("section_objects[" + string(section_index) + "] = " + string(object_list) + ";");
    show_debug_message("section_decor[" + string(section_index) + "] = " + string(decor_list) + ";");
}
