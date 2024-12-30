
if room != rm_title {
    cursor_sprite = spr_blank;
} else {
    cursor_sprite = cr_default;
}

if player_exists() {
    if global.player_state == playerstate.commanding {
        global.cursor_visible = true;
    } else {
        global.cursor_visible = false;
    }
}

if global.endgame {
    global.player_state = playerstate.cutscene;
    global.fadeout = true;
}

if global.fadeout {
    global.fadealpha = approach(global.fadealpha,2,0.01);
}

if global.fadealpha >= 2 {
    global.endgame = false;
    global.fadeout = false
    global.fadealpha = 0;
    room_goto(rm_init);
    audio_stop_sound(wind);
    audio_stop_sound(_22);
}