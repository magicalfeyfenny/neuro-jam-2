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
            if ( input_check_pressed( "interact" ) && input_got ) {
                textlinefadein = 1000;
                input_got = true;
                //input_clear_momentary( "interact" );
            }
            if ( textlinefadein >= 60 + (90 * textlinecount) ) {
                text_advance_ready = TEXT.READY;
            }
        }
        
        if ( frame.display == DISPLAY.ADV ) {
            if (!skipper) {
                textspew += string_char_at(frame.text, spewlength);
                spewlength++;
                skipper = true;
            } else {
                skipper = false;
            }
            if ( input_check_pressed( "interact" ) && !input_got ) {
                textspew = frame.text;
                input_got = true;
            }   
            if (textspew == frame.text ) {
                text_advance_ready = TEXT.READY;
            }
        }
    }
    
    if (text_advance_ready == TEXT.READY ) {
        if ( input_check_pressed( "interact" ) && !input_got ) {
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

input_got = false;