draw_sprite_ext(spr_lever,0,x,y,1,1,lever_rotation,c_white,image_alpha);

draw_self();




if self.flashing = true {    
    shader_set(sh_flash);
    draw_sprite_ext(spr_lever,0,x,y,1,1,lever_rotation,flash_blend,obj_player.border_flash - 0.6);  
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,flash_blend,obj_player.border_flash - 0.6);  
}    



shader_reset();
