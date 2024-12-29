
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