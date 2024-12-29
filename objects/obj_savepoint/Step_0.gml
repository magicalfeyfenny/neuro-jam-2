if ( distance_to_object( obj_player ) < 50 ) {
    save_allowed = true;
} else {
    save_allowed = false;
}

if ( save_allowed ) {
    if ( input_check_pressed( "interact" ) ) {
        save_attempting = true;
    }
}

if ( save_attempting ) {
    if ( input_check_long_pressed( "interact" ) ) {
        //perform the save
        alarm[1] = 1;
    }
}

if ( !save_allowed ) {
    save_attempting = false;
}

if (saved_display > 0) {
    saved_display--;
}

