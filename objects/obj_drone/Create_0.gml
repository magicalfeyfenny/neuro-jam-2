drone_follow_target = obj_player;

follow_player = true;

hovertimer = 0;
hover_y = 0;

idle_hover_point_x = obj_player.x;
idle_hover_point_y = obj_player.y - 64;

distance_from_player = point_distance(x,y,obj_player.x,obj_player.y);

path = 0;

interact_dist = 26;

hsp = 0;
vsp = 0;

accel = 0.1;
decel = 0.1;

movespdmax = 4;
movespd = movespdmax;

hover_spd_x = 0.05;
hover_spd_y = 0.05;

initiate_jump = false;

rotation = 0;

global.drone_state = dronestate.hover;

drone_target = noone;

move_to_target = false;

holding_object = false;

instance_holding = noone;

object_attached = false;

drone_action_registered = false;

drone_target_x = 0;
drone_target_y = 0;

og_depth = depth;
