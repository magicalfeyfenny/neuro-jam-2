data.game.save_point = tag;
data_save();
save_allowed = false;
save_attempting = false;
saved_display = 60;

global.respawn_x = x;
global.respawn_y= y - 6;
