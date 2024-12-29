globalvar data;
globalvar default_game_data;
data = {
    game : { 
        save_point : -1,
        default_start_room : rm_test,
        time : 0,
        //add game-specific data / event flags here
    },
    options : {
        fullscreen : true,
        vsync : true,
    },
    save_points : {
        rooms : [ ],
        position : {
            x : [ ], 
            y : [ ],
        },
        names : [  ],
    },
};

default_game_data = data;
globalvar game_data_size;
game_data_size = string_byte_length( json_stringify( data ) );
globalvar game_data_buffer;
game_data_buffer = buffer_create( game_data_size, buffer_grow, 1 );
globalvar game_data_filename;
game_data_filename = "game_data.json";
globalvar save_screen_name;
save_screen_name = "save_screenshot.png";

globalvar file_loading;
file_loading = false;


alarm[0] = 1;

