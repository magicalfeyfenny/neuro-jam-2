globalvar data;
globalvar default_game_data;
data = {
    game : { 
        save_point : 0,
        time : 0,
        //add game-specific data / event flags here
    },
    options : {
        fullscreen : true,
    },
};

default_game_data = data;
globalvar game_data_size;
game_data_size = string_byte_length( json_stringify( data ) );
globalvar game_data_buffer;
game_data_buffer = buffer_create( game_data_size, buffer_grow, 1 );
globalvar game_data_filename;
game_data_filename = "game_data.json";

alarm[0] = 1;

