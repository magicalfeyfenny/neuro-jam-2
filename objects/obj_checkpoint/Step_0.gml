if ( distance_to_object( obj_player ) < 50 && save_allowed && spawned_in == false) {
    save_attempting = true;
}

if ( save_attempting && spawned_in == false) {
    alarm[1] = 1;
}

saved_display--;