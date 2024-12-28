//array of all solid objects/tilemaps
var col = [obj_par_solid];

//horizontal player movement


if climbing == false {
    var move = input_check("right") - input_check("left");
    
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
        vsp = approach(vsp,climbsp*move,accel);
    } else {
        vsp = approach(vsp,0,decel);
    }
}

//whether or not player is touching ground, should always be a boolean
onground = place_meeting(x,y+1,col);

var wallgrabdistance = 1;

//detect what wall the player is touching and detect whether or not player is sliding down the wall

    if place_meeting(x+wallgrabdistance,y,col) && face_dir == 1 {
        touching_wall = 1;
        if input_check("right") && vsp > 0 && !onground {
            sliding = 1;
        } else {
            sliding = 0;
        }
    } else if place_meeting(x-wallgrabdistance,y,col) && face_dir == -1 {
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


if touching_wall != 0 && input_check("climb") && stamina > 0 {
    climbing = true;
    face_dir = touching_wall;
    mantle = true;
} else {
    climbing = false;
}

if !onground && input_check("climb") && touching_wall == 0 {
    if place_meeting(x+(face_dir*2),y+3,col) {
        if mantle && vsp < 0 {
            var mantle_dist = 3.5;
            hsp += face_dir*mantle_dist;
            mantle = false;
        }    
    } 
}

//gives the player a short time window to jump after leaving the ground
if onground {
    jumpbuffer = jumpbuffermax;	
    mantle = true;
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
if input_check_pressed("jump") {
    initiate_jump = true;
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
    if initiate_jump == true {
        vsp = 0;
        hsp += walljump_spd*(touching_wall * -1);
        vsp += jumpspd;
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
    
    var slide_transition_spd = 0.1;
    
    if sliding != 0 {
        vsp = lerp(vsp,vsp*slide_multiplier,slide_transition_spd);
    }
}   

//player collisions
if place_meeting(x+hsp, y, col) {
    while !place_meeting(x+sign(hsp), y, col) {
        x += sign(hsp);
    }
hsp = 0;
}
x += hsp;

if place_meeting(x, y+vsp, col) {
    while !place_meeting(x, y+sign(vsp), col) {
        y += sign(vsp);
    }
vsp = 0;
}
y += vsp;
