//load the data from the file into the game_data struct
if ( ds_map_find_value(async_load, "id" ) == game_data_buffer ) {
    if ( ds_map_find_value(async_load, "status") == false ) {
        show_error( "File load of " + game_data_filename + " failed", true );
    }
}

//load the data
buffer_seek(game_data_buffer, buffer_seek_start, 0);
data = json_parse( buffer_read( game_data_buffer, buffer_string ) );
game_data_size = string_byte_length( json_stringify( data ) ); 
alarm[1]= 1;
