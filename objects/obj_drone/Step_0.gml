hover_y = sin(hovertimer * 0.1) * 0.25;

switch global.drone_state {
    case dronestate.hover:
        if obj_player.climbing == false {
            with drone_follow_target {
                if place_meeting(x,y,obj_par_interactable) || holding_object || other.holding_object {
                    other.idle_hover_point_x = x; 
                    other.idle_hover_point_y = y - 80;
                } else {
                    other.idle_hover_point_x = x; 
                    other.idle_hover_point_y = y - 58;
                }
            }
                
        } else if drone_follow_target.climbing == true {
            idle_hover_point_x = drone_follow_target.x + (32*(obj_player.face_dir*-1));
            idle_hover_point_y = drone_follow_target.y - 32;
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
                    if input_check_pressed("interact") && inst == noone && col_inst == noone && drone_action_registered == false {
                        drone_target_x = mouse_x;
                        drone_target_y = mouse_y;
                        drone_action_registered = true;
                        global.drone_state = dronestate.execute_action;
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
                } else if global.player_state == playerstate.flying {
                    global.player_state = playerstate.grounded;
                    obj_player.sprite_index = spr_playerjump;
                    sprite_index = spr_dronetest2;
                    obj_player.fly_transition = false;
                    obj_player.rotation = rotation;
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
            }
            
            if obj_player.stamina <= 0 {
                global.player_state = playerstate.grounded;
                obj_player.sprite_index = spr_playerjump;
                sprite_index = spr_dronetest2;
                obj_player.fly_transition = false;
                obj_player.rotation = rotation;
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
                        }
                        
                        if point_distance(x, y, inst.x, inst.y - 32) < 1.5 {
                            move_to_target = true;
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
}

//recall and drop mechanics
if global.player_state == playerstate.commanding {
    if input_check_pressed("jump") {
        follow_player = true;
        global.drone_state = dronestate.hover;
        drone_target = noone;
        drone_target_x = 0;
        drone_target_y = 0;
        move_to_target = false;
        drone_target = noone;
        drone_action_registered = false;
    }
    
    if input_check_pressed("climb") {
        if holding_object {
            instance_holding.interacted = false;
            instance_holding.interacter = noone;   
            instance_holding.set_positions = false;   
            holding_object = false;     
            move_to_target = false;
            instance_holding.hsp = 0;
            instance_holding.vsp = 0;
            instance_holding = noone;
        }    
    }
}