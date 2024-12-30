data.game.save_point = tag;
data_save();
save_allowed = false;
save_attempting = false;
saved_display = 60;

global.respawn_x = obj_player.x;
global.respawn_y= obj_player.y;
