
//drawing the stamina circle with a little fade in animation
//lowkey i havent used surfaces in a while please ignore how messy this is
stamina_x = x - 16;
stamina_y = (y - 48) - stamina_y_trans;

var alphaspd = 0.1;
var transspd = 0.1;

if !surface_exists(stamina_surf) {
    stamina_surf = surface_create(32,32);
}
if (stamina_drain) || (regen_stamina && stamina != staminamax ) {

    stamina_alpha = approach(stamina_alpha,1,alphaspd);
    stamina_y_trans = lerp(stamina_y_trans,0,transspd);
    

    
} else {
    stamina_alpha = approach(stamina_alpha,0,alphaspd);
    stamina_y_trans = lerp(stamina_y_trans,stamina_y_transmax,transspd);
}


surface_set_target(stamina_surf);
draw_set_color(c_black);
var stamina_radius = 6;
draw_circle(12-1,12-1,stamina_radius + 1,false);   
if stamina_drain { 
    var drain_color = merge_color(#ff0000,#ff6f00,color_flash);    
} else {
    if regen_stamina {
        var drain_color = merge_color(#07f73b,#8efa97,color_flash); 
    } else {
        var drain_color = c_lime;
    }
        
}
    
draw_pie(12,12,stamina,staminamax - 4,drain_color,stamina_radius,1);    
draw_pie(12,12,stamina - 6,staminamax - 4,c_lime,stamina_radius,1);    
draw_set_color(c_white); 
surface_reset_target();
draw_surface_ext(stamina_surf, stamina_x - 12, stamina_y - 12,1,1,0,c_white,stamina_alpha);
surface_set_target(stamina_surf);
draw_clear_alpha(c_white,0);
surface_reset_target();