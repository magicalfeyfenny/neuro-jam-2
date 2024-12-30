if (pause) {
    if (!surface_exists(paused_surface)) {
        if (paused_surface == -1) {
            instance_deactivate_all(true);
            instance_activate_object(input_controller_object);
        }
        paused_surface = surface_create(640, 360);
        surface_set_target(paused_surface);
        draw_surface(application_surface, 0, 0);
        surface_reset_target();
    } else {
        draw_surface_ext(paused_surface, 0, 0, 1, 1, 0, c_white, 1);
        draw_set_alpha(0.5);
        draw_set_color(c_black);
        draw_rectangle(-1, -1, 641, 361, false);
        draw_set_alpha(1);
        draw_set_halign( fa_center );
        draw_set_color( c_white );
        draw_set_font( fn_menu );
        draw_text(320, 170, "Paused");
        draw_text(320, 220, "Hold V to exit");
        draw_text(320, 270, "Press Esc to return to the game" );
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        if (allowed_to_quit) {
            draw_rectangle_color(200, 251, 440 - ( quit_timer * 4 ) , 249, c_fuchsia, c_fuchsia, c_fuchsia, c_fuchsia, false);
        }
    }
}