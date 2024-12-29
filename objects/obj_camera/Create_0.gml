//camera set up
#macro view view_camera[0]

global.view_w = 640;
global.view_h = 360;

window_scale = 2;
window_set_size(global.view_w*window_scale,global.view_h*window_scale);
window_center();

surface_resize(application_surface,global.view_w,global.view_h);

view_enabled = true;
view_visible[0] = true;
camera_set_view_size(view,global.view_w,global.view_h);

global.camera_state = camstate.mainmenu;

follow = true;
followtarget = obj_player;
followamt = 0.1;

clamp_y = false;
clamp_x = false;

mouse_len = 0;
mouse_dir = 0;