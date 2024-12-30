//global game object to handle all backend stuff
global.debug = false;

//array of all solid objects/tilemaps
global.col = [obj_par_solid];


mp_grid_tile_size = 32;
global.mp_grid = mp_grid_create(0, 0, room_width/mp_grid_tile_size, room_height/mp_grid_tile_size, mp_grid_tile_size, mp_grid_tile_size);
mp_grid_add_instances(global.mp_grid, obj_par_solid, true);

global.cursor_visible = false;

global.endgame = false;
global.fadeout = false
global.fadealpha = 0;

/*
            //quit
room_goto(rm_init);
audio_stop_sound(wind);

} 
 */