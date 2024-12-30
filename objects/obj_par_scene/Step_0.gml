if (cutscene_mode && timeline_index == timeline_used) {
    if ( timeline_running && dialogue_mode ) {
        timeline_running = false;
    }
    if ( !timeline_running && !dialogue_mode ) {
        timeline_running = true;
    }
}

if (scene_finished) {
    cutscene_mode = false;
    cutscene_number = SCENES.NO_SCENE;
    dialogue_mode = false;
    timeline_running = false;
    timeline_position = 0;
    timeline_index = -1;
    instance_destroy();
}