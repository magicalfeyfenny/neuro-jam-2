if ( distance_to_object( obj_player ) < 50 && !cutscene_mode ) {
    interact_allowed = true;
} else {
    interact_allowed = false;
}

if ( interact_allowed ) {
    if ( input_check_pressed( "interact" ) ) {
        interact_attempting = true;
    }
} else {
    interact_attempting = false;
}

if ( input_check_released( "interact" ) ) {
    interact_attempting = false;
}

if ( interact_attempting ) {
    if ( input_check_long_pressed( "interact" ) ) {
        //perform the save
        alarm[1] = 1;
    }
}

if (cutscene_mode && timeline_index == timeline_used) {
    interact_attempting = false;
    interact_allowed = false;
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
    ds_queue_clear(frames_queue);
    timeline_position = 0; //allow repeat
    timeline_running = false;
    timeline_index = -1;
    scene_finished = false;
}