
    draw_sprite(background1,0,obj_camera.x - global.view_w/2,obj_camera.y - global.view_h/2);
    draw_sprite_ext(background2,0,lerp(0,obj_camera.x - global.view_w/2,0.8),lerp(0,obj_camera.y - global.view_h/2,0.8),room_width,1,0,c_white,1);
    draw_sprite_ext(background3,0,lerp(0,obj_camera.x - global.view_w/2,0.7),lerp(0,obj_camera.y - global.view_h/2,0.7) + 32,room_width,1,0,c_white,1);
    draw_sprite_ext(background4,0,lerp(0,obj_camera.x - global.view_w/2,0.6),lerp(0,obj_camera.y - global.view_h/2,0.6) + 64,room_width,1,0,c_white,1);    
