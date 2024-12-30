if(event_data[? "event_type"] == "sprite event") {
    switch (event_data[? "message"]) {
        case "footstep": 
            audio_play_sound(walking,1,false,0.2,0,random_range(0.8,1.2));
            break;
    }
}
