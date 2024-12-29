if ( title_anim == true ) { 
    title_anim_timer--;
}
if ( title_input_timer > 0 ) {
    title_input_timer--;
    if (title_input_timer == 0) {
        title_input_wait = false;
    }
} 

if ( title_anim_timer <= 0 && title_anim = true ) { //animation ends for current title transition
    title_anim = false;
    switch ( title_state ) {
        case title_init: {
            title_state = title_start;      //move to the next animation immediately after the bg image fades in
            title_anim = true;
            title_input_allow = false;
            title_anim_timer = title_timer_default;
            break;
        }
        case title_start: {
            title_cursor_pos = 0; 
            title_cursor_maxpos = title_start_maxpos;
            title_input_allow = true;
            //wait for input
            break;
        }
        case title_menu: {
            title_cursor_pos = 1;
            title_cursor_maxpos = title_menu_maxpos;
            title_input_allow = true;
            //wait for input
            break;
        }
        case title_load: {
            if (title_anim_reverse == true) {   //if we faded out, then title_menu is the active menu, so fade back to it
                title_state = title_menu;
                title_anim_reverse = false;
                title_anim = true;
                title_anim_timer = title_timer_default;
            } else {
                title_cursor_pos = 0;
                title_cursor_maxpos = title_load_maxpos;
                title_input_allow = true;
                //wait for input
            }
            break;
        }
        case title_newgame: {
            if (title_anim_reverse == true) {   //if we faded out, then title_menu is the active menu, so fade back to it
                title_state = title_menu;
                title_anim_reverse = false;
                title_anim = true;
                title_anim_timer = title_timer_default;
            } else {
                title_cursor_pos = 0;
                title_cursor_maxpos = title_newgame_maxpos;
                title_input_allow = true;
                //wait for input
            }
            break;
        }
        case title_options: {
            if (title_anim_reverse == true) {   //if we faded out, then title_menu is the active menu
                title_state = title_menu;
                title_anim_reverse = false;
                title_anim = true;
                title_anim_timer = title_timer_default;
            } else {
                title_cursor_pos = 1;
                title_cursor_maxpos = title_options_maxpos;
                title_input_allow = true;
                //wait for input
            }
            break;
        }
        case title_credits: {
            if (title_anim_reverse == true) {   //if we faded out, then title_menu is the active menu
                title_state = title_menu;
                title_anim_reverse = false;
                title_anim = true;
                title_anim_timer = title_timer_default;
            } else {
                title_cursor_pos = 0;
                title_cursor_maxpos = title_credits_maxpos;
                title_input_allow = true; 
                //wait for input
            }
            break;
        }
        default: {
            break;
        }
    }
}

if ( title_input_allow ) {
    switch ( title_state ) {
        case title_start: {
            if ( input_check_pressed( [ all ] ) ) {
                title_state = title_menu;
                title_anim = true;
                title_anim_timer = title_timer_default;
                audio_play_sound(snd_select, 0, false);
            }
            break;
        }
        case title_menu: {
            if ( !title_input_wait ) {
                if ( input_check( "up" ) ) {
                    audio_play_sound(snd_menu_move, 0, false);
                    title_input_wait = true;
                    title_input_timer = title_default_delay;
                    title_cursor_pos--;
                    if ( title_cursor_pos <= 0 ) {
                        title_cursor_pos = title_cursor_maxpos;
                    }
                } else if ( input_check( "down" ) ) {
                    audio_play_sound(snd_menu_move, 0, false);
                    title_input_wait = true;
                    title_input_timer = title_default_delay;
                    title_cursor_pos++;
                    if ( title_cursor_pos > title_cursor_maxpos ) {
                        title_cursor_pos = 1;
                    }
                } else if ( input_check_pressed( [ "interact" ] ) ) {
                    audio_play_sound( snd_select, 0, false );
                    title_input_wait = true;
                    title_input_timer = title_default_delay;
                    switch ( title_cursor_pos ) { //execute menu option
                        case 1: {       //load game
                            //load the loader menu
                            title_anim = true;
                            title_state = title_load;
                            title_anim_timer = title_timer_default;
                            break;   
                        }
                        case 2: {       //new game 
                            title_anim = true;
                            title_state = title_newgame;
                            title_anim_timer = title_timer_default;
                            //move to the game room
                            break;   
                        }
                        case 3: {       //options
                            //load the options menu
                            temp_options = json_parse(json_stringify(data.options));
                            title_anim = true;
                            title_state = title_options;
                            title_anim_timer = title_timer_default;
                            break;
                        }
                        case 4: {       //credits
                            //load the credits menu
                            title_anim = true;
                            title_state = title_credits;
                            title_anim_timer = title_timer_default;
                            break;
                        }
                        case 5: {       //exit game
                            //end the game
                            game_end();
                            break;
                        }
                        default: {
                            break;
                        }
                    }
                } else if ( input_check_pressed( "pause" ) ) {
                    audio_play_sound(snd_cancel_2, 0, false);
                    title_input_wait = true;
                    title_input_timer = title_default_delay;
                    title_cursor_pos = title_cursor_maxpos;
                }
            }
            break;
        }
        case title_load: {
            if (!title_input_wait) {
                if ( input_check_pressed( [ "interact" ] ) ) { 
                    audio_play_sound(snd_select, 0, false);
                    alarm[0] = title_fadeout_time;
                    title_input_allow = false;
                    draw_fadeout = true;
                } else if ( input_check_pressed( "pause" ) ) {
                    audio_play_sound( snd_cancel_2, 0, false );
                    title_anim = true;
                    title_anim_reverse = true;
                    title_anim_timer = title_timer_default;
                }
            }
            break;
        }
        case title_newgame: {
            if (!title_input_wait) {
                if (input_check_pressed( [ "interact" ] ) ) {
                    audio_play_sound(snd_select, 0, false);
                    data.game = default_game_data.game;
                    alarm[0] = title_fadeout_time;
                    draw_fadeout = true;
                    title_input_allow = false;
                } else if ( input_check_pressed( "pause" ) ) {
                    audio_play_sound( snd_cancel_2, 0, false );
                    title_anim = true;
                    title_anim_reverse = true;
                    title_anim_timer = title_timer_default;
                }
            }
            break;
        }
        case title_options: {
            if (!title_input_wait) {
                if ( input_check( "up" ) ) {
                    audio_play_sound( snd_menu_move, 0, false );
                    title_input_wait = true;
                    title_input_timer = title_default_delay;
                    title_cursor_pos--;
                    if ( title_cursor_pos <= 0 ) {
                        title_cursor_pos = title_cursor_maxpos;
                    }
                } else if ( input_check( "down" ) ) {
                    audio_play_sound( snd_menu_move, 0, false );
                    title_input_wait = true;
                    title_input_timer = title_default_delay;
                    title_cursor_pos++;
                    if ( title_cursor_pos > title_cursor_maxpos ) {
                        title_cursor_pos = 1;
                    }
                } else if ( input_check_pressed( [ "interact" ] ) ) {
                    audio_play_sound( snd_select, 0, false );
                    title_input_wait = true;
                    title_input_timer = title_default_delay;
                    switch ( title_cursor_pos ) { //execute menu option
                        case 1: {       //fullscreen
                            temp_options.fullscreen = !temp_options.fullscreen;
                            break;   
                        }
                        case 2: {
                            temp_options.vsync = !temp_options.vsync;
                            break;
                        }
                        case title_cursor_maxpos - 2: {       //defaults
                            temp_options = json_parse(json_stringify(default_game_data.options));
                            break;   
                        }
                        case title_cursor_maxpos - 1: {       //save
                            data.options = json_parse(json_stringify(temp_options));
                            data_save();
                            options_load();
                            title_anim = true;
                            title_state = title_options;
                            title_anim_timer = title_timer_default;
                            title_anim_reverse = true;
                            break;
                        }
                        case title_cursor_maxpos: {       //discard
                            options_load();
                            title_anim = true;
                            title_state = title_options;
                            title_anim_timer = title_timer_default;
                            title_anim_reverse = true;
                            break;
                        }
                        default: {
                            break;
                        }
                    }
                } else if ( input_check_pressed( "pause" ) ) {
                    audio_play_sound( snd_cancel_2, 0, false );
                    title_input_wait = true;
                    title_input_timer = title_default_delay;
                    title_cursor_pos = title_cursor_maxpos;
                }
            }
            break;
        }
        case title_credits: {
            if (!title_input_wait) {
                if ( input_check_pressed( [ all ] )) {
                    audio_play_sound( snd_cancel_2, 0, false );
                    title_anim_reverse = true;
                    title_anim = true;
                    title_anim_timer = title_timer_default;
                }
            }
            break;
        }
        default: {
            break;
        }
    }
}


