//check if save file exists, if not create default save
if ( !file_exists( game_data_filename ) ) {
    var default_buffer = buffer_create( game_data_size, buffer_grow, 1 );
    buffer_write( default_buffer, buffer_string, json_stringify(data) );
    buffer_save( default_buffer, game_data_filename );
    buffer_delete( default_buffer );
}

//load the files
buffer_load_async( game_data_buffer, game_data_filename, 0, -1 );