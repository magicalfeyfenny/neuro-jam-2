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

if (pause) {
    if (input_check_pressed( "command" )) {
        allowed_to_quit = true;
    }
    if (input_check( "command" ) && allowed_to_quit ) {
        quit_timer--;
        if (quit_timer <= 0) {
            //end pause
            instance_activate_all();
            surface_free(paused_surface);
            paused_surface = -1;
            //quit
            room_goto(rm_init);
            
        } 
    }
    if (input_check_released( "command") ) {
        allowed_to_quit = false;
        quit_timer = quit_timer_max;
    }
}

if (!pause) {
    data.game.time++;
}
