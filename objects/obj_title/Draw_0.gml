//draw background separately from normal menu
var title_bg_alpha = 1;
if (title_state == title_init && title_anim == true) {
    title_bg_alpha = 1 - (.05 * title_anim_timer);
}
draw_sprite_ext( spr_title_bg, 0, 0, 0, 1, 1, 0, c_white, title_bg_alpha );

switch ( title_state ) {
    case title_start: { 
        var title_alpha = 1;
        if ( title_anim == true ) {
            //show title coming in
            title_alpha = 1 - (.05 * title_anim_timer);
        } else {
            //display 'press a key' or something with the title
            draw_set_halign( fa_center );
            draw_text(320, 250, "press a button");
            draw_set_halign( fa_left );
        }
        draw_sprite_ext( spr_title_image, 0, 200, 100, 1, 1, 0, c_white, title_alpha);
        break;
    }
    case title_menu: {
        draw_sprite_ext( spr_title_image, 0, 200, 100, 1, 1, 0, c_white, 1);
        var title_alpha;
        if ( title_anim == true ) {
            title_alpha = 1 - (.05 * title_anim_timer);
            //show menu animating in
        } else {
            title_alpha = 1;
            //display menu as normal
            if ( title_input_allow ) { 
                draw_sprite( spr_title_cursor, 0, 475 - (title_cursor_pos * 5), 195 + (title_cursor_pos * 20) );
            }
        }
        draw_set_alpha(title_alpha / 2);
        draw_triangle_color( 650, -800, 650, 1200, 650 - (500 * title_alpha), 1200, c_black, c_black, c_black, false );
        draw_set_alpha(1);
        draw_text_color( 490, 205, "Continue", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 485, 225, "New Game", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 480, 245, "Options", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 475, 265, "Credits", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 470, 285, "Exit Game", c_white, c_white, c_white, c_white, title_alpha );
        break;
    }
    case title_load: { 
        draw_sprite_ext( spr_title_image, 0, 200, 100, 1, 1, 0, c_white, 1);
        var title_alpha;
        if ( title_anim == true ) {
            title_alpha = 1 - (.05 * title_anim_timer);
            if ( title_anim_reverse ) {
                title_alpha = ( 1 - title_alpha );
            }
            //animate entering/leaving submenu
        } else {
            //display submenu
            title_alpha = 1; 
            if ( title_anim_reverse ) {
                title_alpha = ( 1 - title_alpha );
            }
        }
        draw_set_alpha(title_alpha / 2);
        draw_roundrect_color( 30, 30, 610, 330, c_black, c_black, false );     //change how these look later 
        draw_set_alpha(1);
        draw_sprite_stretched_ext( load_sprite, 0, 160, 120, 320, 180, c_white, title_alpha );
        draw_text_color( 50, 50, "Load data", c_white, c_white, c_white, c_white, title_alpha );
        var loc = -1;
        var loc_str = "No data saved . . .";
        if ( data.game.save_point < array_length(data.save_points.rooms) && data.game.save_point != -1 ) {
            loc = data.game.save_point;
            loc_str = data.save_points.names[loc];
        }
        var time_hours = string(floor(data.game.time / (60*60*game_get_speed(gamespeed_fps))));
        var time_minutes = string(floor(data.game.time / (60*game_get_speed(gamespeed_fps))));
        var time_seconds = string(floor(data.game.time / game_get_speed(gamespeed_fps) ));
        if (string_length(time_hours) == 1) {
            time_hours = "0" + time_hours;
        }
        if (string_length(time_minutes) == 1) {
            time_minutes = "0" + time_minutes;
        } 
        if (string_length(time_seconds) == 1) {
            time_seconds = "0" + time_seconds;
        }
        draw_text( 70, 80, "Location: " + loc_str );
        draw_text( 70, 100, "Time: " + time_hours + ":" + time_minutes + ":" + time_seconds );
        break;
    }
    case title_newgame: {
        draw_sprite_ext( spr_title_image, 0, 200, 100, 1, 1, 0, c_white, 1); 
        var title_alpha;
        if ( title_anim == true ) {
            title_alpha = 1 - (.05 * title_anim_timer);
            if ( title_anim_reverse ) {
                title_alpha = ( 1 - title_alpha );
            }
            //animate entering/leaving submenu
        } else {
            //display submenu
            title_alpha = 1; 
            if ( title_anim_reverse ) {
                title_alpha = ( 1 - title_alpha );
            }
        }
        draw_set_alpha(title_alpha / 2);
        draw_roundrect_color( 30, 30, 610, 330, c_black, c_black, false );     //change how these look later
        draw_set_alpha(1);
        draw_text_color( 50, 50, "New game", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 70, 80, "Start a new file", c_white, c_white, c_white, c_white, title_alpha );
        break;
    }
    case title_options: { 
        draw_sprite_ext( spr_title_image, 0, 200, 100, 1, 1, 0, c_white, 1);
        var title_alpha;
        if ( title_anim == true ) {
            title_alpha = 1 - (.05 * title_anim_timer);
            if ( title_anim_reverse ) {
                title_alpha = ( 1 - title_alpha );
            }
            //animate entering/leaving submenu
        } else {
            //display submenu
            title_alpha = 1; 
            if ( title_anim_reverse ) {
                title_alpha = ( 1 - title_alpha );
            }
            if ( title_input_allow ) { 
                if (title_cursor_pos <= (title_cursor_maxpos - 3)) {
                    draw_sprite( spr_title_cursor, 0, 50, 70 + (title_cursor_pos * 20) );
                } else {
                    draw_sprite( spr_title_cursor, 0, 50, 240 + ((title_cursor_pos - (title_cursor_maxpos - 3)) * 20) );
                }
            }
        } 
        draw_set_alpha(title_alpha / 2);
        draw_roundrect_color( 30, 30, 610, 330, c_black, c_black, false );     //change how these look later
        draw_set_alpha(1);
        draw_text_color( 50, 50, "Options", c_white, c_white, c_white, c_white, title_alpha );
        var fullscreen_on = "off";
        if ( temp_options.fullscreen == true ) {
            fullscreen_on = "on";
        }
        draw_text_color( 70, 80, "Fullscreen: " + fullscreen_on, c_white, c_white, c_white, c_white, title_alpha );
        var vsync_on = "off";
        if ( temp_options.vsync == true ) {
            vsync_on = "on";
        }
        draw_text_color( 70, 100, "VSync: " + vsync_on, c_white, c_white, c_white, c_white, title_alpha);
        draw_text_color( 70, 250, "Defaults", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 70, 270, "Save changes", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 70, 290, "Discard changes", c_white, c_white, c_white, c_white, title_alpha );
        break;
    }
    case title_credits: {
        draw_sprite_ext( spr_title_image, 0, 200, 100, 1, 1, 0, c_white, 1);
        var title_alpha;
        if ( title_anim == true ) {
            title_alpha = 1 - (.05 * title_anim_timer);
            if ( title_anim_reverse ) {
                title_alpha = ( 1 - title_alpha );
            }
            //animate entering/leaving submenu
        } else {
            //display submenu
            title_alpha = 1; 
            if ( title_anim_reverse ) {
                title_alpha = ( 1 - title_alpha );
            }
        }
        draw_set_alpha(title_alpha / 2);
        draw_roundrect_color( 30, 30, 610, 330, c_black, c_black, false );     //change how these look later
        draw_set_alpha(1);
        draw_text_color( 50, 50, "Credits", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 70, 80, "Scenario:", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 90, 100, "noellepunk", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 70, 120, "Programming:", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 90, 140, "noellepunk", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 90, 160, "magicalfeyfenny", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 70, 180, "Art/Visuals:", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 90, 200, "sasumeat", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 70, 220, "Sound/Music:", c_white, c_white, c_white, c_white, title_alpha );
        draw_text_color( 90, 240, "asmn15", c_white, c_white, c_white, c_white, title_alpha );
        break;
    }
}

if (draw_fadeout) { 
    var draw_alpha = 1 - (alarm_get(0) / title_fadeout_time)
    draw_set_alpha( draw_alpha );
    show_debug_message( draw_alpha );
    draw_rectangle_color( -5, -5, 645, 365, c_black, c_black, c_black, c_black, false );
    draw_set_alpha(1);
}
