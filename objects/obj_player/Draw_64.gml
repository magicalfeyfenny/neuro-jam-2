if border_flash > 0 {
    draw_set_alpha(border_flash - 0.25);
    draw_sprite(spr_commandborder,0,0,0)
    draw_set_alpha(1);
    draw_text(16,16," C = Recall");
    draw_text(16,32," X = Interact");
    draw_text(16,48," Z = Drop Item");
    }
