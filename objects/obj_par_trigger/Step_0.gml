if instance_exists(trigger_target) {
    if place_meeting(x,y,trigger_target) {
        triggered = true;
    } else {
        if !trigger_once {
            triggered = false;
        }    
    }
}