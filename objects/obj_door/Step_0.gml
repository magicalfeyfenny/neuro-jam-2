if open {
    if sprite_index != spr_dooropen{
        audio_play_sound(laseractivatedeactivate,1,false,1,0,1.1);
    }
    sprite_index = spr_dooropen;
} else {
    if sprite_index != spr_door{
        audio_play_sound(laseractivatedeactivate,1,false,1,0,0.6);
    }
    sprite_index = spr_door;
}

