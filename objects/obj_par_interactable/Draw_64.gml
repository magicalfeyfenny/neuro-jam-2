if global.debug && interacted {
    draw_text(display_get_gui_width() - 184,16,"Interacted : " + string(interacted))
    draw_text(display_get_gui_width() - 184,34,"Interacter : " + object_get_name(interacter))
}