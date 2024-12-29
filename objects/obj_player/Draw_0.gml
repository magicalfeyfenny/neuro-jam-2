var drone_sprite = -1;

if instance_exists(obj_drone){
    drone_sprite = obj_drone.sprite_index;
}

if drone_sprite != spr_playerflying {
        draw_sprite_ext(sprite_index,image_index,x,y,face_dir,image_yscale,rotation,image_blend,image_alpha);
}