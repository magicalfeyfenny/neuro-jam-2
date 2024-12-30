with (global.scene_drone) {
    drone_follow_target = obj_player;
    idle_hover_point_x = obj_player.x;
    idle_hover_point_y = obj_player.y - 64;
}

with (global.scene_target) {
    instance_destroy();
}

instance_destroy();