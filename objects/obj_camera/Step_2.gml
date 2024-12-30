if room == rm_title || room == rm_init {
    x = room_width/2;
    y = room_height/2;
} else {
    if instance_exists(followtarget){
        var playeroffset_y = 64;
        if followtarget == obj_player {
            switch global.player_state {
                default:
                    if global.player_state != playerstate.dead { 
                        x = lerp(x,followtarget.x + obj_player.hsp,followamt);
                        y = lerp(y,(followtarget.y - playeroffset_y) + obj_player.vsp,followamt);  
                    } else {
                        if global.bodyretrieved {
                            x = lerp(x,global.respawn_x,followamt);
                            y = lerp(y,(global.respawn_x - playeroffset_y),followamt);  
                        }        
                    }    

                break;
                
                case playerstate.commanding:
                    mouse_len = point_distance(obj_player.x,obj_player.y,mouse_x,mouse_y);
                    //mouse_len = clamp(mouse_len,0,160);
                    mouse_dir = point_direction(obj_player.x,obj_player.y,mouse_x,mouse_y);
                    var mousediv = 2
                    x =	lerp(x,((followtarget.x) + lengthdir_x(mouse_len/mousediv,mouse_dir)),followamt);
                    y =	lerp(y,((followtarget.y) + lengthdir_y(mouse_len/mousediv,mouse_dir)),followamt);
                break; 
            }
        } else {
            x = lerp(x,followtarget.x,followamt);
            y = lerp(y,followtarget.y,followamt);
        }
    }	
}

if clamp_x {
    x = clamp(x,global.view_w/2,room_width - global.view_w/2);
}

if clamp_y {
    y = clamp(y,global.view_h/2,room_height - global.view_h/2);
}

//apply camera shake values 
x += random_range(-shake_remain,shake_remain);
y += random_range(-shake_remain,shake_remain);
shake_remain = max(0,shake_remain - ((1/shake_length)*shake_magnitude));

camera_set_view_pos(view,x-global.view_w/2,y-global.view_h/2);