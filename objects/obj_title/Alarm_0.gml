audio_stop_all();
file_loading = true;
if ( data.game.save_point == -1 || data.game.save_point >= array_length( data.save_points.rooms ) ) {
    room_goto( data.game.default_start_room );
} else {
    room_goto( data.save_points.rooms[ data.game.save_point ] );   
}