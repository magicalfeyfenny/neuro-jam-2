
if player_exists() {
    if global.player_state == playerstate.commanding {
        global.cursor_visible = true;
    } else {
        global.cursor_visible = false;
    }
}