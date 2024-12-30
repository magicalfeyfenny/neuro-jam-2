audio_emitter_position(drone_ambience, x, y, 0);
if !audio_is_playing(droneambient) {
    //audio_play_sound(droneambient,1,true,0.5,0,2);
    //audio_play_sound_at(droneambient,x,y,0,16,128,false,0.5,1,3);
    audio_play_sound_on(drone_ambience, droneambient, false, 1, 0.2,0,2);
}

hover_y = sin(hovertimer * 0.1) * 0.25;

switch global.drone_state {
    case dronestate.hover:
        
        //set drone hover positions here
        if !cutscene_mode {
            if obj_player.climbing == false {
                with drone_follow_target {
                    if place_meeting(x,y,obj_par_interactable) || holding_object || other.holding_object {
                        other.idle_hover_point_x = x; 
                        other.idle_hover_point_y = y - 80;
                    } else {
                        if place_meeting(x,(y - 18) - 48,global.col) {

                            other.idle_hover_point_x = x; 
                            other.idle_hover_point_y = y - 46;
                        } else {
                             other.idle_hover_point_x = x; 
                            other.idle_hover_point_y = y - 58; 
                        }
                    }
                }
                    
            } else if drone_follow_target.climbing == true {
                idle_hover_point_x = drone_follow_target.x + (32*(obj_player.face_dir*-1));
                idle_hover_point_y = drone_follow_target.y - 32;
            }
        }
        distance_from_player = point_distance(x,y,obj_player.x,obj_player.y - 16);
        
        hovertimer++;
        

        if holding_object {
            hover_spd_x = 0.025;
            hover_spd_y = 0.025;
            depth = obj_player.depth + 1;
        } else {
            depth = og_depth;
            hover_spd_x = 0.05;
            hover_spd_y = 0.05;
        }
        if obj_player.vsp > 0 {
            hover_spd_y = lerp(hover_spd_y,0.05,0.1);
        } else if obj_player.vsp < 0 {
            hover_spd_y = lerp(hover_spd_y,0.005,0.1);
        }
        
        var player_visible = collision_line(x,y,obj_player.x,obj_player.y - 16,global.col,true,true);
        
        /*
        if player_visible == noone {
            path_end();
            y = lerp(y,idle_hover_point_y + hover_y,hover_spd);
            x = lerp(x,idle_hover_point_x,hover_spd);
        } else {
            var pathspd = 3;
            path = path_add();
            if (mp_grid_path(global.mp_grid, path, x, y, idle_hover_point_x, obj_player.y - 8, 1))
            {
                path_set_kind(path, 1);
                path_set_precision(path, 4);
                path_start(path, pathspd, path_action_stop, true);
            }
        }*/
        var offset = 32;
        var pathspd = 3;
        switch global.player_state {

            default:

                
                if follow_player == true {
                        if distance_from_player > 70 {
                            y = lerp(y,idle_hover_point_y,hover_spd_y); 
                        } else if distance_from_player <= 70{
                            y = lerp(y,idle_hover_point_y,hover_spd_y) + hover_y; 
                        }
                            
                        x = lerp(x,idle_hover_point_x,hover_spd_x);
                } else {
                    y += hover_y;
                }
                
                
                //check if we're telling the drone to move to a specific location instead of grabbing an object
                if global.player_state == playerstate.commanding {
                    var inst = instance_position(mouse_x,mouse_y,obj_par_interactable)
                    var col_inst = instance_position(mouse_x,mouse_y,obj_par_solid)
                    has_los = collision_line(mouse_x, mouse_y, obj_player.x, obj_player.y - 24, global.col, false, true);
                    if input_check_pressed("interact") {
                        if inst == noone && drone_action_registered == false{
                            if col_inst == noone {
                                if has_los == noone {
                                    if variable_instance_exists(instance_holding,"is_lever") {
                                        instance_holding.interacted = false;
                                        instance_holding.interacter = noone;
                                        holding_object = false;     
                                        instance_holding = noone;
                                        move_to_target = false;
                                        audio_play_sound(dronedrop,1,false);
                                    } 
                                    drone_target_x = mouse_x;
                                    drone_target_y = mouse_y;
                                    drone_action_registered = true;
                                    global.drone_state = dronestate.execute_action; 
                                    audio_play_sound(drone_command,1,false);
                                } else {
                                    screenshake();
                                    drone_error = true;
                                    drone_error_message = "REQUIRES LINE OF SIGHT";
                                }
                            }   else {
                                screenshake();
                                drone_error = true;
                                drone_error_message = "INVALID POSITION";
                            }

        
                        }
                    }    

                }
            
                rotation = lerp(rotation,0,0.1);
            break;
            
            case playerstate.flying:
                if obj_player.fly_transition == true {
                    var xmove = input_check("right") - input_check("left");
                    var ymove = input_check("down") - input_check("up");
                
                    if xmove != 0 {
                        hsp = approach(hsp,movespd*xmove,accel);
                        obj_player.face_dir = xmove;
                    } else {
                        hsp = approach(hsp,0,decel);
                    }
                    
                    if ymove != 0 {
                        vsp = approach(vsp,movespd*ymove,accel);
                    } else {
                        vsp = approach(vsp,0,decel);
                    }
                
                    obj_player.hsp = hsp;
                    obj_player.vsp = vsp;
                
                    if vsp == 0 && ymove == 0{
                        vsp += hover_y;
                    }
                    
                    var throw_spd = 7;
                    if initiate_jump == true {
                        rotation = approach(rotation,hsp*6,throw_spd)
                    } else {
                        rotation = -(hsp*6);
                    }
                        
                
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
                    }
                    y += vsp;
                }
            break;
        }
        
            
        
        if distance_from_player <= interact_dist {
            if input_check_pressed("interact") && obj_player.holding_object == false && holding_object == false {
                if global.player_state == playerstate.grounded {
                    global.player_state = playerstate.flying;
                    vsp = (obj_player.vsp/1.5);
                    hsp = (obj_player.hsp/1.5);
                    obj_player.hsp = 0;
                    obj_player.vsp = 0;
                    audio_play_sound(dronesound2,1,true);
                    mask_index = spr_playerflying
                } else if global.player_state == playerstate.flying {
                    global.player_state = playerstate.grounded;
                    obj_player.sprite_index = spr_playerjump;
                    sprite_index = spr_dronetest2;
                    obj_player.fly_transition = false;
                    mask_index = spr_dronetest2;
                    obj_player.rotation = rotation;
                    audio_stop_sound(dronesound2);
                    audio_play_sound(dronedrop,1,false);
                    with obj_player {
                        while place_meeting(x,y,global.col) {
                            y--;
                        }
                    }
                }
            }
            
            if input_check_pressed("jump") && global.player_state == playerstate.flying {
                initiate_jump = true;    
            }
            
            if initiate_jump && rotation == hsp*6{
                obj_player.hsp += hsp;
                obj_player.vsp += vsp;
                obj_player.accel = 0.1;
                obj_player.deccel = 0.1;
                global.player_state = playerstate.grounded;
                obj_player.sprite_index = spr_playerjump;
                sprite_index = spr_dronetest2;
                obj_player.fly_transition = false;
                initiate_jump = false;
                obj_player.x = x + (4*sign(hsp));
                obj_player.y = y + 38; 
                obj_player.rotation = rotation;
                audio_stop_sound(dronesound2);
                audio_play_sound(droneinteract,1,false);
                mask_index = spr_dronetest2;
                with obj_player {
                    while place_meeting(x,y,global.col) {
                        y--;
                    }
                }
            }
            
            if obj_player.stamina <= 0 {
                global.player_state = playerstate.grounded;
                obj_player.sprite_index = spr_playerjump;
                sprite_index = spr_dronetest2;
                obj_player.fly_transition = false;
                obj_player.rotation = rotation;
                audio_stop_sound(dronesound2);
                if !audio_is_playing(dronedrop) {
                    audio_play_sound(dronedrop,1,false);
                }    
                mask_index = spr_dronetest2;
                with obj_player {
                    while place_meeting(x,y,global.col) {
                        y--;
                    }
                }
            }
        }
    break;
    
    case dronestate.execute_action:
        hover_spd_x = 0.05;
        hover_spd_y = 0.05;
        var offset = 32;
        var pathspd = 3;
        if drone_action_registered {
            if drone_target != noone {
                    var inst = drone_target;
                    
                    if inst.holdable {
                        /*var pathspd = 3;
                        path = path_add();
                        if (mp_grid_path(global.mp_grid, path, x, y, inst.x, inst.y - 48, 1))
                        {
                            path_set_kind(path, 1);
                            path_set_precision(path, 8);
                            path_start(path, pathspd, path_action_stop, true);
                        }*/
                        
                        if move_to_target == false { 
                            x = lerp(x,inst.x,hover_spd_x);
                            y = lerp(y,inst.y - 32, hover_spd_y);    
                        } else if inst.interacter != obj_drone && move_to_target == true {
                            inst.interacter = object_index;
                            holding_object = true;
                            instance_holding = inst;
                            inst.interacted = true;
                            follow_player = false;
                            move_to_target = false;
                            drone_target = noone;
                            drone_action_registered = false;
                            obj_player.holding_object = false;
                            obj_player.instance_holding = noone;
                            audio_play_sound(droneinteract,1,false);
                        }
                        
                        if point_distance(x, y, inst.x, inst.y - 32) < 1.5 {
                            move_to_target = true;
                        }
                        
        
                    } else {
                        if variable_instance_exists(inst,"is_lever") {
                            if move_to_target == false { 
                                x = lerp(x,inst.x,hover_spd_x);
                                y = lerp(y,inst.y - 8, hover_spd_y);    
                            } else if move_to_target == true && inst.interacter != obj_drone && inst.interacter != obj_player {
                                follow_player = false;
                                move_to_target = false;
                                drone_target = noone;
                                drone_action_registered = false;
                                holding_object = true;
                                instance_holding = inst;
                                inst.interacted = true;
                                inst.interacter = object_index;
                                audio_play_sound(droneinteract,1,false);
                            }
                            
                            if point_distance(x, y, inst.x, inst.y - 8) < 1.5 {
                                move_to_target = true;
                            }
                        }
                    }
                } else if drone_target == noone {


                        x = lerp(x,drone_target_x,hover_spd_x);
                        y = lerp(y,drone_target_y - offset, hover_spd_y); 
                        
                        if point_distance(x, y, drone_target_x, drone_target_y - offset) < 2 {
                            drone_action_registered = false;
                            follow_player = false;
                        }
                    
                }
    
        } else {
            global.drone_state = dronestate.hover;
            drone_target = noone;
            drone_target_x = 0;
            drone_target_y = 0;
        }
    

    break;
    
    case dronestate.retrieveplayer:
        if global.bodyretrieved {
            var d_offset = 48;
            sprite_index = spr_playerflying;
            if retrievertimer-- < 0 {
                if !global.reachedrespawn {
                    x = lerp(x,global.respawn_x,hover_spd_x);
                    y = lerp(y,global.respawn_y - d_offset, hover_spd_y); 
                }    
                
                
                if point_distance(x, y, global.respawn_x, global.respawn_y - d_offset) < 2 {
                    global.reachedrespawn = true;
                }
                
                if global.reachedrespawn {
                    global.player_state = playerstate.grounded;
                    sprite_index = spr_dronetest2;
                    global.bodyretrieved = false;
                    global.reachedrespawn = false;
                    global.drone_state = dronestate.hover;
                    follow_player = true;
                    retrievertimer = retrievetimermax;
                    audio_play_sound(dronedrop,1,false);
                }
            }    

        }
    break;
}

//recall and drop mechanics
if global.player_state == playerstate.commanding {
    if input_check_pressed("jump") {
        if variable_instance_exists(instance_holding,"is_lever") {
            instance_holding.interacted = false;
            instance_holding.interacter = noone;
            holding_object = false;     
            instance_holding = noone;
        }
        follow_player = true;
        global.drone_state = dronestate.hover;
        drone_target = noone;
        drone_target_x = 0;
        drone_target_y = 0;
        move_to_target = false;
        drone_target = noone;
        drone_action_registered = false;
        audio_play_sound(dronerecall,1,false);
    }
    
    if input_check_pressed("climb") {
        if instance_holding != noone { 
            with instance_holding {
                if other.holding_object && !place_meeting(x,y,global.col) {
                    if variable_instance_exists(other.instance_holding,"is_lever") {
                        interacted = false;
                        interacter = noone;
                        other.holding_object = false;     
                        other.instance_holding = noone;
                        other.move_to_target = false;
                        audio_play_sound(dronedrop,1,false);
                    } else {
                            interacted = false;
                            interacter = noone;   
                            other.holding_object = false;     
                            other.move_to_target = false;
                            hsp = 0;
                            vsp = 0;
                            other.instance_holding = noone;  
                            audio_play_sound(dronedrop,1,false);
                    }               

                } else {
                    screenshake();
                }   
            }    
        }    

 
    }
}

if global.player_state == playerstate.dead {
    audio_stop_sound(dronesound2);
    if instance_holding != noone { 
        with instance_holding {
            if other.holding_object && !place_meeting(x,y,global.col) {
                if variable_instance_exists(other.instance_holding,"is_lever") {
                    interacted = false;
                    interacter = noone;
                    other.holding_object = false;     
                    other.instance_holding = noone;
                    other.move_to_target = false;
                    audio_play_sound(dronedrop,1,false);
                } else {
                        interacted = false;
                        interacter = noone;   
                        other.holding_object = false;     
                        other.move_to_target = false;
                        hsp = 0;
                        vsp = 0;
                        other.instance_holding = noone;  
                        audio_play_sound(dronedrop,1,false);
                }               

            }  
        }    
    }   
}

var drone_alpha_spd = 0.1;

if drone_error {
    drone_error_alpha = approach(drone_error_alpha,1,drone_alpha_spd);
    if drone_error_timer-- < 0 {
        drone_error = false;
        drone_error_timer = drone_error_timermax;
    }
} else {
    drone_error_alpha = approach(drone_error_alpha,0,drone_alpha_spd);
}