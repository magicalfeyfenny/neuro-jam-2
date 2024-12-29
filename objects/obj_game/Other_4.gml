global.mp_grid = mp_grid_create(0, 0, room_width/mp_grid_tile_size, room_height/mp_grid_tile_size, mp_grid_tile_size, mp_grid_tile_size);
mp_grid_add_instances(global.mp_grid, obj_par_solid, true);