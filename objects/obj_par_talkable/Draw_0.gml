draw_self();
if (interact_attempting) {
    draw_rectangle_color( x - 10, y - 50, x - 9 + (18 * min(1, (input_held_time("interact") / INPUT_LONG_DELAY) )), y - 48, c_fuchsia, c_fuchsia, c_fuchsia, c_fuchsia, false );
    draw_rectangle_color( x - 10, y - 50, x + 10, y - 47, c_black, c_black, c_black, c_black, true);   
}
sparkle_counter++;
if ( (sparkle_counter % 8) == 0 ) {
    hold_x = irandom(32);
    hold_y = irandom(32);
    hold_frame = irandom(16);
}
if (!cutscene_mode) {
    draw_sprite(spr_interactable_glint, hold_frame, x - 16 + hold_x, y - 48 + hold_y); 
}
//draw_sprite(spr_interactable_glint, ((sparkle_counter % 128) / 8), x - 10 + hold_x, y - 30 + hold_y);