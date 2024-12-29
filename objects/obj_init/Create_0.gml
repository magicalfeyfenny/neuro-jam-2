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
        vsync : true,
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

globalvar save_points;
save_points = {
    rooms : [ rm_test, rm_test, rm_test ],
    position : {
        x : [ 300, 200, 100 ], 
        y : [ 50, 100, 150 ],
    },
    names : [ "save 0", "save 1", "save 2" ],
};

alarm[0] = 1;

