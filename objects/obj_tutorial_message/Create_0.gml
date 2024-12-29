// Inherit the parent event
event_inherited();

draw_message = false;

message_alpha = 0;

fade_spd = 0.1;
offset_spd = 0.1;

message_timermax = message_duration*60;
message_timer = message_timermax;

message_confirmed = false;

message_offsetmax = 32;
message_offset = message_offsetmax;