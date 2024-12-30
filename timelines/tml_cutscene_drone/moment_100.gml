with (global.scene_drone) {
    drone_follow_target = obj_player;
    idle_hover_point_x = drone_follow_target.x;
    idle_hover_point_y = drone_follow_target.y - 64;
}

instance_destroy();