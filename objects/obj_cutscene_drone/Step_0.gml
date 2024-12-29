if (cutscene_mode) {
    if ( timeline_running && dialogue_mode ) {
        timeline_running = false;
    }
    if ( !timeline_running && !dialogue_mode ) {
        timeline_running = true;
    }
}