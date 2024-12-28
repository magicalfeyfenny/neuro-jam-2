title_init = 0;
title_start = 1;
title_menu = 2;
title_load = 3;
title_options = 4;
title_credits = 5;

title_state = title_init;
title_anim = true;
title_anim_reverse = false;         //used to reverse the animation for submenus
title_input_allow = false;
title_input_wait = false;
title_input_timer = 0;
title_default_delay = 5;

title_timer_default = 20;
title_anim_timer = title_timer_default;

title_cursor_pos = 0;
title_cursor_maxpos = 0;            //if maxpos is 0, no cursor or only 1 input, if it is > 0, it's a menu
title_start_maxpos = 0;
title_menu_maxpos = 5;              //current options: new, load, options, credits, exit
title_load_maxpos = 0;
title_options_maxpos = 4;           //1 test menu option, defaults, discard, save
title_credits_maxpos = 0;

