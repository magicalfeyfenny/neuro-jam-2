// Inherit the parent event
event_inherited();

if triggered && message_timer == message_timermax{
    draw_message = true;
}

if draw_message {
    message_alpha = approach(message_alpha,1,fade_spd);
    message_offset = lerp(message_offset,0,offset_spd);
} else{
    message_alpha = approach(message_alpha,0,fade_spd);
    message_offset = lerp(message_offset,message_offsetmax,offset_spd);
}

if (input_check_pressed(confirm_key) || input_check_pressed(confirm_key2)) && draw_message {
    message_confirmed = true;
}

if message_confirmed && draw_message {
    message_timer--;
    if message_timer < 0 {
        draw_message = false;
    }
}