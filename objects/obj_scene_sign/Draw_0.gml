draw_self();
if (interact_attempting) {
    draw_rectangle_color( x - 10, y - 50, x - 9 + (18 * min(1, (input_held_time("interact") / INPUT_LONG_DELAY) )), y - 48, c_fuchsia, c_fuchsia, c_fuchsia, c_fuchsia, false );
    draw_rectangle_color( x - 10, y - 50, x + 10, y - 47, c_black, c_black, c_black, c_black, true);   
}