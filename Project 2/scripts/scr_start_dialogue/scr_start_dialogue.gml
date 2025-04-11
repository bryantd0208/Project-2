/// @function scr_start_dialogue(lines_array, optional_portrait)

if (!layer_exists("GUI")) {
    show_debug_message("GUI layer not ready! Dialogue delayed.");
    exit; // GUI doesn't exist yet, exit safely
}

var _textbox = instance_exists(obj_textbox) ? instance_find(obj_textbox, 0) : instance_create_layer(0, 0, "GUI", obj_textbox);

_textbox.dialogue_lines = argument0;
_textbox.text_index = 0;
_textbox.current_text = argument0[0];
_textbox.visible = true;
_textbox.char_index = 0;
_textbox.char_timer = 0;

if (argument_count > 1) {
    _textbox.portrait_sprite = argument1;
}
else {
    _textbox.portrait_sprite = -1; // No portrait
}
