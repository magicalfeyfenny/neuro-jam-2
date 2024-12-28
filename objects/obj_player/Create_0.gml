//horizontal and vertical player speed
hsp = 0;
vsp = 0;

//gravity
base_grv = 0.3334;
grv = base_grv;

//walk speed
walkspmax = 2.25;
walksp = walkspmax;

//player acceleration and deacceleration
accel = 0.25;
decel = 0.25;

//player state
global.player_state = playerstate.grounded;

//jumping variables
jumpmax = 1;
jumpcount = 0;

jumpspd = -4

jumpframes = 8;
jumptimer = 0;

jumpbuffermax = 6;
jumpbuffer = jumpbuffermax;

initiate_jump = false;
jump_input_timer_max = 10;
jump_input_timer = jump_input_timer_max;

onground = true;

face_dir = 1;

//walljump variables
walljump_spd = 5;
touching_wall = 0;
slide_multiplier = 0.1;
sliding = 0;

//climbing variables
climbing = false;
stamina = 100;
climbspmax = 1.5;
climbsp = climbspmax;
mantle = true;