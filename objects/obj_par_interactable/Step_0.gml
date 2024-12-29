if holdable {
    var player_y_offset = 48;
    var drone_y_offset = 16;
    if interacted {
        var setpositionspd = 0.3;
            if interacter == obj_player {
                x = lerp(x,interacter.x + interacter.hsp,setpositionspd);
                y = lerp(y,(interacter.y - player_y_offset) + interacter.vsp,setpositionspd);
            } else if interacter == obj_drone { 
                x = lerp(x,interacter.x + interacter.hsp,setpositionspd);
                y = lerp(y,(interacter.y + drone_y_offset) + interacter.vsp,setpositionspd);
            }
    }
}

if has_physics && !interacted {
    vsp += grav;
    
    
    if place_meeting(x+hsp, y, global.col) {
        while !place_meeting(x+sign(hsp), y, global.col) {
            x += sign(hsp);
        }
    hsp = 0;
    }
    x += hsp;
    
    if place_meeting(x, y+vsp, global.col) {
        while !place_meeting(x, y+sign(vsp), global.col) {
            y += sign(vsp);
        }
    vsp = 0;
    hsp = approach(hsp,0,fric);
    } else {
        hsp = approach(hsp,0,air_fric);
    }
    y += vsp;
}

if player_exists() && instance_exists(obj_drone) {
    if global.player_state == playerstate.commanding {
        var inst = instance_position(mouse_x,mouse_y,obj_par_interactable)
        if inst != noone {
            if interacted == false {
                flashing = true;
            }    
            if input_check_pressed("interact") && obj_drone.drone_action_registered == false && obj_drone.holding_object == false    {
                global.drone_state = dronestate.execute_action;
                obj_drone.drone_target = inst;
                obj_drone.drone_action_registered = true;
            }
        } else {
            flashing = false;   
        }
    } else {
        flashing = false; 
    }
}

var flashspd = 0.05;



if flash_state == 0{
    flash_alpha = approach(flash_alpha,1,flashspd);
    if flash_alpha == 1 {
        flash_state = 1;
    }
} else if flash_state == 1 {
    flash_alpha = approach(flash_alpha,0,flashspd);
    if flash_alpha == 0 {
        flash_state = 0;
    }
}
