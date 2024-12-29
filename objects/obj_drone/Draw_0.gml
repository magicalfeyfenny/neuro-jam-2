draw_sprite_ext(sprite_index,image_index,x,y,obj_player.face_dir,image_yscale,rotation,image_blend,image_alpha);

    
if global.debug {
    draw_text(x,y - 32,string(floor(distance_from_player)));
    if path_exists(path) { 
        draw_path(path,x,y,true);
    }    
}