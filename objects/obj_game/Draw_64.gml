if global.debug {
    draw_text(8,8,"Room : " + room_get_name(room));
    if player_exists() {
        draw_text(8,8,"Room : " + room_get_name(room));
        draw_text(8,32,"HSP : " + string(obj_player.hsp));
        draw_text(8,56,"VSP : " + string(obj_player.vsp));
        draw_text(8,80,"jump_input_timer : " + string(obj_player.jump_input_timer));
        draw_text(8,104,"initiate_jump : " + string(obj_player.initiate_jump));
        draw_text(8,128,"jump_timer : " + string(obj_player.jumptimer));
        draw_text(8,152,"jump_buffer : " + string(obj_player.jumpbuffer));
        draw_text(8,176,"touching_wall : " + string(obj_player.touching_wall));
        draw_text(8,200,"player state : " + string(global.player_state));
        draw_text(8,224,"climbing : " + string(obj_player.climbing));
        draw_text(8,248,"onground : " + string(obj_player.onground));
        draw_text(8,272,"face_dir : " + string(obj_player.face_dir));
    }
    draw_text( 8, 296, "cutscene_mode : " + string( cutscene_mode ) );
    draw_text( 8, 320, "cutscene_number : " + string( cutscene_number ));
    draw_text( 8, 344, "dialogue_mode : " + string( dialogue_mode ) );
}

if global.fadealpha > 0 {
    draw_set_alpha(global.fadealpha)
    draw_rectangle_color(0,0,display_get_gui_width(),display_get_gui_height(),c_black,c_black,c_black,c_black,false);
     draw_set_alpha(1)
    
}