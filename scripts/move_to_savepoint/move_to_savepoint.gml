function move_to_savepoint( goto, player ) {
    //create the save points for the room
    for (var i = 0; i < array_length(save_points.rooms); i++) {
        if ( save_points.rooms[i] == room ) {
            var obj = instance_create_depth( save_points.position.x[i], save_points.position.y[i], 5, obj_savepoint );
            with (obj) {
                tag = i;
            }
        }
    }
    //if the save data's current save point exists in the room, move the player to that save point
    if ( save_points.rooms[ goto ] == room ) {
        player.x = save_points.position.x[ goto ];        //rename to whatever object name is being used for the player
        player.y = save_points.position.y[ goto ];   
    }
}