window_scale = 2;
window_set_size(global.view_w*window_scale,global.view_h*window_scale);
window_center();
//ensure that default room camera is always enabled
view_enabled = true;
view_visible[0] = true;
camera_set_view_size(view,global.view_w,global.view_h);

if player_exists() {
    global.camera_state = camstate.gameplay;	
} else {
    if room == rm_title {
        global.camera_state = camstate.mainmenu;	
    }
}

