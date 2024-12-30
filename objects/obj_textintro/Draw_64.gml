var yoffset = 64;

if page == 1 {
    for (var i = 0; i < array_length(page1text); i++) {
        draw_set_halign(fa_center) 
        draw_set_font(fn_menu_tutorial)
        draw_set_alpha(page1textalpha);
        draw_set_color(c_white);
        draw_text(display_get_gui_width()/2,(64 * i) + yoffset,page1text[i]);
        draw_set_font(-1)
        draw_set_alpha(1);
        draw_set_halign(fa_left);
    }
} else if page == 2 {
        for (var i = 0; i < array_length(page2text); i++) {
        draw_set_halign(fa_center) 
        draw_set_font(fn_menu_tutorial)
        draw_set_alpha(page2textalpha);
        draw_set_color(c_white);
        draw_text(display_get_gui_width()/2,(64 * i) + (yoffset - 16),page2text[i]);
        draw_set_font(-1)
        draw_set_alpha(1);
        draw_set_halign(fa_left);
    }
}    

if confirm_alpha > 0 {
    draw_set_halign(fa_center) 
    draw_set_font(fn_menu_tutorial)
    draw_set_alpha(confirm_alpha);
    draw_set_color(c_white);
    draw_text(display_get_gui_width()/2,(display_get_gui_height() - 24),"(Press X to continue.)");
    draw_set_font(-1)
    draw_set_alpha(1);
    draw_set_halign(fa_left);
}