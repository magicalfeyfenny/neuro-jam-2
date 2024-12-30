if (!cutscene_mode && timeline_used != noone) {
    interact_allowed = false;
    interact_attempting = false;
    cutscene_mode = true;
    timeline_index = timeline_used;
}