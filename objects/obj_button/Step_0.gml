if door != noone {
    if activated {
        door.open = true;
    } else {
        door.open = false;
    }
}

var colarray = [obj_player, obj_par_interactable];

if place_meeting(x,y-1,colarray) {
    activated = true;
    if image_index < image_number - 1  {
        image_speed = 1;
    } else if image_index == image_number - 1 {
            if image_speed != 0 {
                audio_play_sound(buttonpressed,1,false,1,0,1);
            }    
        image_speed = 0;
    }
} else {
    activated = false;
    if image_index > 1 {
        image_speed = -1;
    } else if image_index == 1 {
        if image_speed != 0 {
            audio_play_sound(buttonunpressed,1,false,1,0,1);
        }   
        image_speed = 0;
    }
}