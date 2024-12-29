draw_self();

shader_set(sh_flash);


if flashing = true {    
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,flash_blend,obj_player.border_flash - 0.6);  
}    

   

shader_reset();
