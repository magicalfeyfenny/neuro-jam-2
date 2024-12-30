if holdable {
    var player_y_offset = 48;
    var drone_y_offset = 16;
    var spr_h = sprite_get_height(sprite_index);
    if interacted {
        var setpositionspd_player = 0.3;
        var setpositionspd_drone = 0.5;
            if interacter == obj_player {
                x = lerp(x,(obj_player.x + (obj_player.face_dir * 4) ) + obj_player.hsp,setpositionspd_player);
                y = lerp(y,(obj_player.y - spr_h*1.6) + obj_player.vsp,setpositionspd_player);
            } else if interacter == obj_drone { 
                x = lerp(x,obj_drone.x,setpositionspd_drone);
                y = lerp(y,(obj_drone.y + spr_h/2),setpositionspd_drone);
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
    
    if place_meeting(x,y+1,global.col) {
        if hitground == false {
            //audio_play_sound(physics_sound,1,false,1,0,random_range(0.8,1));
            hitground = true;
        }
    } else {
        hitground = false;
    }
}


if player_exists() && instance_exists(obj_drone) {
    if global.player_state == playerstate.commanding {
        var inst = instance_position(mouse_x,mouse_y,obj_par_interactable)

        if inst != noone {
            has_player_los = collision_line(inst.x, inst.y, obj_player.x, obj_player.y - 24, global.col, false, true);
            if interacter != obj_drone {
                inst.flashing = true;
            }    

            if input_check_pressed("interact") {
                if obj_drone.drone_action_registered == false && obj_drone.holding_object == false{
                     if has_player_los == noone {
                        global.drone_state = dronestate.execute_action;
                        obj_drone.drone_target = inst;
                        obj_drone.drone_action_registered = true;
                        audio_play_sound(drone_command,1,false);
                    } else {
                                        screenshake();
                                        with obj_drone {
                                            drone_error = true;
                                            drone_error_message = "REQUIRES LINE OF SIGHT";
                                        }
                                    }

                } 
            }
        } else {
            self.flashing = false;   
        }
    } else {
        self.flashing = false; 
    }
}

