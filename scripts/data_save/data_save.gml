function data_save(){    
    buffer_delete(game_data_buffer);
    game_data_size = string_byte_length(json_stringify(data));
    game_data_buffer = buffer_create(game_data_size, buffer_grow, 1);
    buffer_write(game_data_buffer, buffer_string, json_stringify(data) );
    buffer_save(game_data_buffer, game_data_filename);
    buffer_delete(game_data_buffer);
}