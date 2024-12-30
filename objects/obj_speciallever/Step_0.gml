// Inherit the parent event
event_inherited();




    if interacted {
        lever_rotation = approach(lever_rotation,lever_rot_target,lever_spd);
        if lever_rotation <= lever_rot_target {
            if activated != true {
                audio_play_sound(snd_switch,1,false,1,0,0.9);
            }
            activated = true;
            global.endgame = true;
        }
    } else {
        if global.endgame != true {
            lever_rotation = approach(lever_rotation,0,lever__return_spd);
        }
        if lever_rotation > lever_rot_target/2 {
            if activated != false {
                audio_play_sound(snd_switch,1,false,1,0,0.8);
            }
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