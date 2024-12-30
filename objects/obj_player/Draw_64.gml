if border_flash > 0 {
    draw_set_alpha(border_flash - 0.25);
    draw_sprite(spr_commandborder,0,0,0)
    draw_set_font(fn_menu)
    draw_set_alpha(1);
    var outline_offset = 1;
    draw_set_color(c_black);
    draw_text(16+outline_offset,20+outline_offset," C = Recall");
    draw_text(16+outline_offset,40+outline_offset," X = Interact");
    draw_text(16+outline_offset,60+outline_offset," Z = Drop Item");
    
    draw_set_color(c_white);
    draw_text(16,20," C = Recall");
    draw_text(16,40," X = Interact");
    draw_text(16,60," Z = Drop Item");
    }


if global.player_state == playerstate.flying {
    draw_set_font(fn_menu)
    draw_set_alpha(1);
    var outline_offset = 1;
    draw_set_color(c_black);
    draw_text(16+outline_offset,20+outline_offset," C = Momentum Jump");
    draw_text(16+outline_offset,40+outline_offset," X = Drop Down");
    
    draw_set_color(c_white);
    draw_text(16,20," C = Momentum Jump");
    draw_text(16,40," X = Drop Down");
}


