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
jump_input_timer_max = 6;
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
climbspmax = 1.5;
climbsp = climbspmax;
mantle = true;
climb_accel = 0.5;
climb_deccel = 0.5;

//stamina variables
staminamax = 100;
stamina = staminamax;
regen_stamina = true;
stamina_drain = false;
stamina_drain_amt = 0.5;
stamina_recover_amt = 1.5;

color_flash = 0;
flash_state = 0;

border_flash = 0;
border_flashmin = 0.5;
border_flash_state = 2;


stamina_x = 0;
stamina_y = 0;
stamina_y_transmax = 8;
stamina_y_trans = stamina_y_transmax;
stamina_alpha = 0;

stamina_surf = -1;

fly_transition = false;

holding_object = false;
instance_holding = noone;

rotation = 0;

landtimer = 0;