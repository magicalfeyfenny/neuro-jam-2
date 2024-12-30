var fadespd = 0.01;
var cfadespd = 0.01;
if state == 0 {
    page1textalpha = approach(page1textalpha,1,fadespd)
    if page1textalpha >= 1  {
        confirm_alpha = approach(confirm_alpha,1,cfadespd);
        if input_check_pressed("interact") {
            state = 1;
        }
    }
} else if state == 1 {
    page1textalpha = approach(page1textalpha,0,fadespd);
    confirm_alpha = approach(confirm_alpha,0,cfadespd);
    if page1textalpha <= 0 {
        state = 2;
    }
} else if state == 2 {
    page = 2;
    page2textalpha = approach(page2textalpha,1,fadespd)
    if page2textalpha >= 1 {
        confirm_alpha = approach(confirm_alpha,1,cfadespd);
        if input_check_pressed("interact") {
            state = 3;
        }
        
    }
} else if state == 3 {
        confirm_alpha = approach(confirm_alpha,0,cfadespd);
        page2textalpha = approach(page2textalpha,-1,fadespd);
    if page2textalpha <= -1 {
        room_goto(rm_level1);
    }
}