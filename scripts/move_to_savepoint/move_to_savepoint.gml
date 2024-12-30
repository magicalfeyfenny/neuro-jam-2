function generate_savepoints( ) {
    var savepoints_listed = 0;
    //create the save points for the room
    for (var i = 0; i < array_length(data.save_points.rooms); i++) {
        if ( data.save_points.rooms[i] == room ) {
            savepoints_listed++;
            if (instance_number(obj_savepoint) < savepoints_listed ) {
                var obj = instance_create_depth( data.save_points.position.x[i], data.save_points.position.y[i], 5, obj_savepoint );
                with (obj) {
                    tag = i;
                    name = data.save_points.names[i];
                }
            } else {
                var obj = instance_nearest( data.save_points.position.x[i], data.save_points.position.y[i], obj_savepoint );
                with (obj) {
                    tag = i;
                    if (name == "") {
                        name = data.save_points.names[i];
                    }
                }
                data.save_points.position.x[i] = obj.x;
                data.save_points.position.y[i] = obj.y;
                data.save_points.names[i] = obj.name;
            }
        }
    }
    if (savepoints_listed < instance_number( obj_savepoint ) ) {
        with ( obj_savepoint ) {
            if (tag < 0) {
                var new_pos = array_length(data.save_points.rooms);
                array_resize( data.save_points.names, new_pos + 1 );
                array_resize( data.save_points.position.x, new_pos + 1 );
                array_resize( data.save_points.position.y, new_pos + 1 );
                array_resize( data.save_points.rooms, new_pos + 1);
                data.save_points.names[new_pos] = name;
                data.save_points.position.x[new_pos] = x;
                data.save_points.position.y[new_pos] = y;
                data.save_points.rooms[new_pos] = room;
                tag = new_pos;
            }
        }
    }
}

function move_to_savepoint( goto, player ) {
    //if the save data's current save point exists in the room, move the player to that save point
    if ( data.save_points.rooms[ goto ] == room ) {
        with ( instance_position(data.save_points.position.x[goto], data.save_points.position.y[goto], obj_checkpoint) ) {    //if it's a checkpoint, disable it
            save_allowed = false;
            spawned_in = true;
        }
        player.x = data.save_points.position.x[ goto ];        //rename to whatever object name is being used for the player
        player.y = data.save_points.position.y[ goto ];   
    }
}