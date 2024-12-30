switch global.player_state {
    case playerstate.grounded:
        //horizontal player movement
        if climbing == false {
            var move = 0;
            
            if  !cutscene_mode {
                move = input_check("right") - input_check("left");
            }
                
            
            if move != 0 {
                hsp = approach(hsp,walksp*move,accel);
            } else {
                hsp = approach(hsp,0,decel);
            }
            
            if move != 0 { 
                face_dir = move;    
            }    
        } else {
            var move = input_check("down") - input_check("up");
            
            if move != 0 {
                vsp = approach(vsp,climbsp*move,climb_accel);
            } else {
                vsp = approach(vsp,0,climb_deccel);
            }
        }
        
        //whether or not player is touching ground, should always be a boolean
        onground = place_meeting(x,y+1,global.col);
        
        var wallgrabdistance = 4;
        
    if holding_object == false && !cutscene_mode {
            //detect what wall the player is touching and detect whether or not player is sliding down the wall
            if place_meeting(x+wallgrabdistance,y,global.col) && face_dir == 1 {
                touching_wall = 1;
                if input_check("right") && vsp > 0 && !onground {
                    sliding = 1;
                } else {
                    sliding = 0;
                }
            } else if place_meeting(x-wallgrabdistance,y,global.col) && face_dir == -1 {
                touching_wall = -1; 
                if input_check("left") && vsp > 0  && !onground {
                    sliding = -1;
                } else {
                    sliding = 0;
                }
            } else {
                touching_wall = 0;
                sliding = 0;
            }
            
            if stamina_drain && regen_stamina == false {
                if climbing { 
                    if move != 0 {
                        stamina = approach(stamina,0,stamina_drain_amt);
                    } else {
                        stamina = approach(stamina,0,stamina_drain_amt/2);
                    }
                }   
            } else if regen_stamina {
                stamina = approach(stamina,staminamax,stamina_recover_amt);
            }
            
            //climbing
            if touching_wall != 0 && input_check("climb") && stamina > 0 && !cutscene_mode{
                climbing = true;
                face_dir = touching_wall;
                mantle = true;
                regen_stamina = false;
                stamina_drain = true;
                while !place_meeting(x+face_dir,y,global.col) {
                    x += face_dir;
                }
            } else {
                climbing = false;
            }
            
            //automatically mantle up a ledge when climbing upwards
            if !onground && input_check("climb") && touching_wall == 0 && !cutscene_mode{
                if place_meeting(x+(face_dir*2),y+3,global.col) {
                    if mantle && vsp < 0 {
                        var mantle_dist = 3.5;
                        hsp += face_dir*mantle_dist;
                        mantle = false;
                    }    
                } 
            }
    }
        //gives the player a short time window to jump after leaving the ground
        if onground {
            jumpbuffer = jumpbuffermax;	
            mantle = true;
            regen_stamina = true;
            stamina_drain = false;
            accel = 0.25;
            decel = 0.25;
            rotation = approach(rotation,0,2);
        } else {
            jumpbuffer--;	
        }
        
        if jumpbuffer >= 0 {
            jumpcount = 0;
        } else if jumpbuffer < 0 {
            if jumpcount == 0 {	
                jumpcount = 1;	
            }
        }
        
        //jump system that includes variable jumping and a jump buffer to make movement smoother and more responsive
        if input_check_pressed("jump") && !cutscene_mode {
            initiate_jump = true;
            landtimer = 0;
        }
        
        
        if touching_wall == 0 || onground {
            //normal jumping
            if initiate_jump == true && jumpcount < jumpmax {
                jumpcount++;
                jumptimer = jumpframes;
                if vsp != 0 {	
                    vsp = 0;
                }
                initiate_jump = false;
                jump_input_timer = jump_input_timer_max; 
            } else if initiate_jump == true && !onground {
                if jump_input_timer-- <= 0 {
                    initiate_jump = false;
                    jump_input_timer = jump_input_timer_max;
                }
            }
        } else {
            //wall jump
            if initiate_jump == true && holding_object == false {
                face_dir = (touching_wall * -1);
                vsp = 0;
                hsp += walljump_spd*(touching_wall * -1);
                vsp += (jumpspd*1.5);
                initiate_jump = false;
                jump_input_timer = jump_input_timer_max; 
            }
        }
        
        if !input_check("jump") && !onground {
            jumptimer = 0;
        }
        
        if jumptimer > 0 {
            vsp = jumpspd;
        
            jumptimer--;
        }
        
        
        if climbing == false {
            vsp += grv;
            
            var slide_transition_spd = 0.25;
            
            if sliding != 0 {
                vsp = lerp(vsp,vsp*slide_multiplier,slide_transition_spd);
            }
        }   
        
        vsp = clamp(vsp,-8,6);
        
        //picking up objects    
        if (input_check_pressed("interact") && !cutscene_mode) { 
            if instance_holding != noone {
                if instance_holding.interacted {
                    instance_holding.interacted = false;
                    instance_holding.interacter = noone;   
                    instance_holding.set_positions = false;   
                    instance_holding.hsp = hsp;
                    instance_holding.vsp = vsp;
                    instance_holding = noone;
                    holding_object = false;     
                }
            } else {
                if place_meeting(x,y,obj_par_interactable) && onground && instance_holding == noone && holding_object == false { 
                    var inst = instance_place(x,y,obj_par_interactable);
                    if inst.holdable {
                        if inst.interacted == false {
                            inst.interacted = true;
                            inst.interacter = object_index;  
                            inst.hsp = 0;
                            inst.vsp = 0;
                            holding_object = true;              
                            instance_holding = inst;       
                        }
                    }    
                }
            }
        }
    
        if ( input_check_pressed("command") && instance_exists(obj_drone) && !cutscene_mode ) {
            global.player_state = playerstate.commanding;
            border_flash_state = 0;
            var center_x = window_get_x() + window_get_width()/2
            var center_y = window_get_y() + window_get_height()/2
            
            display_mouse_set(center_x,center_y);
        }

    
        //player global.collisions
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
    
    rotation = approach(rotation,0,1);
    break;
    

    case playerstate.flying:
        if instance_exists(obj_drone) {
            var fly_trans_spd = 0.25;
            var fly_y = 38;
            if  fly_transition == false {
                x = lerp(x,obj_drone.x,fly_trans_spd);
                y = lerp(y,obj_drone.y + fly_y ,fly_trans_spd);
                
                if point_distance(x, y, obj_drone.x, obj_drone.y + fly_y) < 1.5 {
                    fly_transition = true;
                }
            } else { 
                obj_drone.sprite_index = spr_playerflying;
                sprite_index = spr_blank;
                x = obj_drone.x;
                y = obj_drone.y + fly_y; 
                regen_stamina = false;
                stamina_drain = true;
                
                
                var fly_drain_amt = 0.2 + abs(hsp/12);
                if stamina_drain {
                    stamina = approach(stamina,0,fly_drain_amt);
                }
            }

        }
    break;
    
    case playerstate.commanding:
    
    onground = place_meeting(x,y+1,global.col);
    
    stamina = approach(stamina,staminamax,stamina_recover_amt);

    if input_check_pressed("command") {
        global.player_state = playerstate.grounded;
        border_flash_state = 2;
        var center_x = window_get_x() + window_get_width()/2
        var center_y = window_get_y() + window_get_height()/2
        
        display_mouse_set(center_x,center_y);
    }
     
    hsp = approach(hsp,0,decel);
    
    vsp += grv;
    
    vsp = clamp(vsp,-8,6);
    
    //player global.collisions
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
    
    rotation = approach(rotation,0,1);
    
    break;
    
    //cutscene state
    case playerstate.cutscene:
    
    onground = place_meeting(x,y+1,global.col);
    
    stamina = approach(stamina,staminamax,stamina_recover_amt);
     
    
    if cutscene_move != 0 {
        hsp = approach(hsp,walksp*cutscene_move,accel);
    } else {
        hsp = approach(hsp,0,decel);
    }
    
    if cutscene_move != 0 { 
        face_dir = cutscene_move;    
    }  
    
    vsp += grv;
    
    vsp = clamp(vsp,-8,6);
    
    //player global.collisions
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
    
    rotation = approach(rotation,0,1);
    break;
}

var flashspd = 0.1;

if flash_state == 0 {
    color_flash = approach(color_flash,1,flashspd);
    if color_flash == 1 {
        flash_state = 1;
    }
} else if flash_state == 1 {
    color_flash = approach(color_flash,0,flashspd);
    if color_flash == 0 {
        flash_state = 0;
    }
}

var borderflashspd = 0.025;

if border_flash_state == 0 && border_flash_state != 2{
    border_flash = approach(border_flash,1,borderflashspd);
    if border_flash == 1 {
        border_flash_state = 1;
    }
} else if border_flash_state == 1 {
    border_flash = approach(border_flash,border_flashmin,borderflashspd);
    if border_flash == border_flashmin {
        border_flash_state = 0;
    }
} else if border_flash_state == 2 {
    border_flash = approach(border_flash,0,borderflashspd);
} 


mask_index = spr_playertest;
if !climbing {
    if onground {
        if sprite_index != spr_playerjump && landtimer > 6 {
            if hsp != 0 {
                sprite_index = spr_playerwalk;
                image_speed = hsp/walkspmax;
            } else if hsp == 0 {
                sprite_index = spr_playeridle;
                image_speed = 0;
            }
        } else {
            sprite_index = spr_playerland;
            landtimer++;
        }
    } else {
        if sliding == 0 {
            sprite_index = spr_playerjump; 
            image_speed = 0;       
        } else { 
            sprite_index = spr_playerslide; 
            image_speed = 0;   
        }
            
    }
} else {
    sprite_index = spr_playerwallclimb;
    image_speed = vsp/walkspmax;
}
