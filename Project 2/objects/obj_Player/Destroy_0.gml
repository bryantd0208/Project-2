// Reset all levers visually and logically
with (obj_Switch) {
    state = 0;
    flip_registered = false;
}

// Clear lever flip queue
if (variable_global_exists("lever_flip_queue")) {
    ds_list_clear(global.lever_flip_queue);
}

// Clear section lever states
if (ds_map_exists(global.lever_states, current_background_index)) {
    var new_map = ds_map_create();
    ds_map_replace(global.lever_states, current_background_index, new_map);
}
