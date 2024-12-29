if ( dialogue_mode ) {
    if ( text_advance_ready == TEXT.LOADING && !ds_queue_empty( frames_queue ) ) {
        text_advance_ready = TEXT.TYPING;
        frame = ds_queue_dequeue( frames_queue );
        if (bg != frame.bg) {
            bg_anim_timer = bg_anim_time;
            bg_anim = true;
            last_bg = bg;
        }
        bg = frame.bg;
        if (mus != frame.mus) {
            mus_switch = true;
            last_mus = mus;
        }
        mus = frame.mus;
        if (frame.audio != -1) {
            audio_play = true;
        }
        actor_name = frame.name;
        textspew = "";
        textlines = [ "", "", "", "", "", "", "" ];
        textlinecount = 1;
        spewlength = 1;
    }
    
    if (text_advance_ready == TEXT.TYPING ) {
        if ( frame.display == DISPLAY.FULLSCREEN ) {
            for( var i = 1; i <= string_length(frame.text); i++ ) {
                textlines[textlinecount] += string_char_at(frame.text, spewlength);
                if (string_char_at(frame.text, spewlength) == "\n") {
                    textlinecount++;
                }
                spewlength++;
            }
            textlinefadein++;
            if ( input_check_pressed( confirm_input ) ) {
                textlinefadein = 1000;
                input_clear_momentary( confirm_input);
            }
            if ( textlinefadein >= 60 + (90 * textlinecount) ) {
                text_advance_ready = TEXT.READY;
            }
        }
        
        if ( frame.display == DISPLAY.ADV ) {
            textspew += string_char_at(frame.text, spewlength);
            spewlength++;
            if ( input_check_pressed( confirm_input ) ) {
                textspew = frame.text;
                input_clear_momentary( confirm_input );
            }
            if (textspew == frame.text ) {
                text_advance_ready = TEXT.READY;
                show_debug_message( frame.text );
                show_debug_message( "textspew: " +  textspew );
            }
        }
    }
    
    if (text_advance_ready == TEXT.READY ) {
        if ( input_check_pressed( confirm_input ) ) {
            textlinefadein = 0;
            text_advance_ready = TEXT.LOADING;
            if (ds_queue_empty(frames_queue) ) {
                dialogue_mode = false;
            }
        }
    }
}

if (bg_anim == true) {
    bg_anim_timer--;
    if (bg_anim_timer <= 0 ) {
        bg_anim = false;
    }
}

if (mus_switch == true ) {
    if (last_mus != -1 ) {
        audio_stop_sound( last_mus );
    }
    if (mus != -1) {
        audio_play_sound( mus, 0, true );   
    }
    mus_switch = false;
}

if (audio_play == true) {
    audio_play_sound( frame.audio, 0, false );
    audio_play = false;
}