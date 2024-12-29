if message_alpha > 0 {
    draw_set_halign(fa_center) 
    draw_set_font(tutorial_font)
    draw_set_alpha(message_alpha);
    var outlineoffset = 1;
    draw_set_color(c_black);
    draw_text((display_get_gui_width()/2) + outlineoffset,(64 - message_offset) + outlineoffset,tutorial_message);
    draw_set_color(c_white);
    draw_text(display_get_gui_width()/2,64 - message_offset,tutorial_message);
    draw_set_font(-1)
    draw_set_alpha(1);
    draw_set_halign(fa_left);

}