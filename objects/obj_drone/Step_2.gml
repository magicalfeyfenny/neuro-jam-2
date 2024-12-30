if global.bodyretrieved && global.player_state == playerstate.dead && global.drone_state == dronestate.retrieveplayer {
    obj_player.x = x;
    obj_player.y = y + 32;
}