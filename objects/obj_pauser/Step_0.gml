menu_wait--;

if (input_check_pressed( "pause" ) && menu_wait <= 0 ) {
    menu_wait = menu_wait_default;
    pause = !pause;
    if (!pause) {
        //end pause
        instance_activate_all();
        surface_free(paused_surface);
        paused_surface = -1;
    }
}

if (!pause) {
    data.game.time++;
}
