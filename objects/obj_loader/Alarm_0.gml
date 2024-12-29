generate_savepoints()
if ( file_loading == true && data.game.save_point != -1 && data.game.save_point < array_length(data.save_points.rooms) ) {
    move_to_savepoint( data.game.save_point , obj_player );
}
file_loading = false;