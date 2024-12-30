if (cutscene_mode && timeline_index == timeline_used) {
    if ( timeline_running && dialogue_mode ) {
        timeline_running = false;
    }
    if ( !timeline_running && !dialogue_mode ) {
        timeline_running = true;
    }
}