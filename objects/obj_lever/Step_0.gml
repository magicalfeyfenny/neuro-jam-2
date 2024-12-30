// Inherit the parent event
event_inherited();


if interacted {
    lever_rotation = approach(lever_rotation,lever_rot_target,lever_spd);
    if lever_rotation <= lever_rot_target/2 {
        activated = true;
    }
} else {
    lever_rotation = approach(lever_rotation,0,lever__return_spd);
    if lever_rotation > lever_rot_target/2 {
        activated = false;
    }
}

if door != noone {
    if activated {
        door.open = true;
    } else {
        door.open = false;
    }
}


if player_exists() {
    if !place_meeting(x,y,obj_player) && interacter != obj_drone {
        interacted = false;
        interacter = noone;
    }
}