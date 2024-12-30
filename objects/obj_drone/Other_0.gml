if global.player_state == playerstate.dead {
    global.drone_state = dronestate.retrieveplayer;
    global.bodyretrieved = true;
}