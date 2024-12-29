if room == rm_title || room == rm_init {
    x = room_width/2;
    y = room_height/2;
} else {
    if instance_exists(followtarget){
        if followtarget == obj_player {
            x = lerp(x,followtarget.x,followamt);
            y = lerp(y,followtarget.y,followamt); 
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

camera_set_view_pos(view,x-global.view_w/2,y-global.view_h/2);