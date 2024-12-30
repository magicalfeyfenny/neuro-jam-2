if drone_error_alpha > 0 {
    draw_set_halign(fa_center) 
    draw_set_font(fn_menu)
    draw_set_alpha(drone_error_alpha);
    var outlineoffset = 1;
    draw_set_color(c_black);
    draw_text((display_get_gui_width()/2) + outlineoffset,(display_get_gui_height() - 64) + outlineoffset,drone_error_message);
    draw_set_color(c_red);
    draw_text(display_get_gui_width()/2,display_get_gui_height() - 64,drone_error_message);
    draw_set_font(-1)
    draw_set_alpha(1);
    draw_set_halign(fa_left);

}