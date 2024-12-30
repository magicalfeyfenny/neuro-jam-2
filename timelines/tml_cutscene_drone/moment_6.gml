global.scene_target = instance_create_layer( 4300, 330, "Props", obj_scene_target );

global.scene_drone = instance_create_layer( 4800, 360, "Player", obj_drone );

with (global.scene_drone) { 
    drone_follow_target = global.scene_target.object_index;
    idle_hover_point_x = drone_follow_target.x;
    idle_hover_point_y = drone_follow_target.y;
}