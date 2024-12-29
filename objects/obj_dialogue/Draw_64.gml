if ( dialogue_mode ) {
    if ( bg_anim == true && last_bg != -1 ) {
        draw_sprite_ext( last_bg, 0, 0, 0, 1, 1, 0, c_white, (bg_anim_timer / bg_anim_time) ); 
        draw_sprite_ext( bg, 0, 0, 0, 1, 1, 0, c_white, 1 - (bg_anim_timer / bg_anim_time) );
    } else {
        draw_sprite_ext( bg, 0, 0, 0, 1, 1, 0, c_white, 1 );
    }
    
    if (array_length( frame.sprite ) > 0) {
        for (var i = 0; i < array_length( frame.sprite ); i++ ) {
            draw_sprite( frame.sprite[i], 0, frame.sprite_pos_x[i], frame.sprite_pos_y[i] );
        }
    }
    
    if ( frame.display == DISPLAY.ADV ) {
        narrator_alpha = 0;
        draw_set_halign( fa_left );
        draw_sprite( spr_text_box, 0, 30, 220 );
        
        draw_set_font( fn_dialogue_names );
        draw_text( 85, 225, frame.name );
        
        draw_set_font( fn_dialogue_text );
        draw_text( 75, 265, textspew );
    }
    
    if (frame.display == DISPLAY.FULLSCREEN ) {
        draw_set_color(c_black);
        narrator_alpha++;
        draw_set_alpha( min( 1, narrator_alpha / bg_anim_time ) / 2 );
        draw_rectangle( -1, -1, 641, 361, false );
        draw_set_color(c_white);
        draw_set_font(fn_dialogue_text);
        draw_set_halign(fa_center);
        for (var i = 1; i <= textlinecount + 1; i++ ) {
            draw_set_alpha( (-10 - (80 * i) + textlinefadein) / 60 );
            draw_text(320, 180 - (20 * textlinecount) + (40 * (i - 1)), textlines[i]);
        }
        draw_set_halign(fa_left);
    }
    
    if (text_advance_ready == TEXT.READY ) {
        loopdoop++;
        draw_set_alpha(1);
        var pos_x = 540;
        var pos_y = 300;
        if ( frame.display == DISPLAY.FULLSCREEN ) {
            pos_x = 320;
            pos_y = 320;
        }
        draw_sprite(spr_text_arrow, round((loopdoop % 160) / 20), pos_x, pos_y);
    }
}

