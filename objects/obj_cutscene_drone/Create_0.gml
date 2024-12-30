event_inherited();
timeline_used = tml_cutscene_drone;
if (data.game.lv1_endscene_played) {
    instance_create_layer( x, y, "Drone", obj_drone );
    instance_destroy();
}