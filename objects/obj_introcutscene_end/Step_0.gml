// Inherit the parent event
event_inherited();

if triggered && instance_exists(obj_player) {
    obj_player.cutscene_move = 0;
    global.player_state = playerstate.grounded;
    instance_destroy();
}